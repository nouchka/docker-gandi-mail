#!/bin/sh

DEBUG=$1

list_forward () {
  curl -X GET \
    https://api.gandi.net/v5/email/forwards/$GANDI_DOMAIN?page=$1 \
    -H "Authorization: Apikey $GANDI_API_KEY"|jq -r '.[] | .source + ";" + .destinations[]' > /tmp/list.tmp
  cat /tmp/list.tmp >> /tmp/list.csv.tmp
}

create_forward () {
  echo "create $1 $2"
  sleep 2
  curl -X POST \
    https://api.gandi.net/v5/email/forwards/$GANDI_DOMAIN \
    -H "authorization: Apikey $GANDI_API_KEY" \
    -H 'content-type: application/json' \
    -d '{"source":"'$1'","destinations":["'$2'"]}'
}

delete_forward () {
  echo "delete $1"
  sleep 2
  curl -X DELETE \
    https://api.gandi.net/v5/email/forwards/$GANDI_DOMAIN/$1 \
    -H "authorization: Apikey $GANDI_API_KEY"
}

rm -rf /tmp/*

list_forward 1
x=2
while [ -s "/tmp/list.tmp" ]
do
  list_forward $x
  x=$(( $x + 1 ))
done

sort mails.csv|awk -F ';' '{print $1";"$2}' > /tmp/target.csv
sort /tmp/list.csv.tmp > /tmp/list.csv

if [ ! -s "/tmp/list.csv" ]; then
	exit 1
fi

if [ $DEBUG ]; then
	echo "Target =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	cat /tmp/target.csv
	echo "Actual =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	cat /tmp/list.csv
	echo "========>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
fi

##DELETE
diff --changed-group-format='%>' --unchanged-group-format='' /tmp/target.csv /tmp/list.csv| while read alias
do
	delete_forward $(echo $alias|awk -F ';' '{print $1}')
done

##CREATE
diff --changed-group-format='%<' --unchanged-group-format='' /tmp/target.csv /tmp/list.csv| while read alias
do
	create_forward $(echo $alias|awk -F ';' '{print $1}') $(echo $alias|awk -F ';' '{print $2}')
done
