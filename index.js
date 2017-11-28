var xmlrpc = require('xmlrpc')
const csv = require('csv-streamify')
const fs = require('fs')
var alias = new Object()
var apikey = process.env.GANDI_API_KEY
var domain = process.env.GANDI_DOMAIN
var sleep = require('sleep')

var api = xmlrpc.createSecureClient({
  host: 'rpc.gandi.net',
  port: 443,
  path: '/xmlrpc/'
 })
var mailCount = 0;
var trashCount = 0;

api.methodCall('version.info', [apikey], function (error, value) {
  console.dir(value)
})

const parser = csv({ delimiter: ';', objectMode: true, quote: "'" }, function (err, result) {
  if (err) throw err
  // our csv has been parsed succesfully
  result.forEach(function (line) {
    var mail
    if (line[1] !== undefined && line[1] != '') {
      mail = line[1].toLowerCase()
      mailCount++;
    } else {
      console.log('No mail for ' + line[0])
    }
    if (alias[line[0]] != mail) {
      console.log('Alias ' + line[0] + ' Current ' + alias[line[0]] + ' Target ' + mail)
      if (alias[line[0]] === undefined) {
        console.log('Creation of forward: ' + line[0])
        api.methodCall('domain.forward.create', [apikey, 'katagena.com', line[0], {'destinations': [mail]}], function (error, value) {
          console.dir(value)
        })
      } else if (mail === undefined) {
        console.log('Delete forward: ' + line[0])
        sleep.sleep(10)
        api.methodCall('domain.forward.delete', [apikey, 'katagena.com', line[0]], function (error, value) {
            console.dir(value)
          })
      } else if (alias[line[0]] != mail) {
        console.log('Update of forward: ' + line[0])
        sleep.sleep(6)
        api.methodCall('domain.forward.update', [apikey, 'katagena.com', line[0], {'destinations': [mail]}], function (error, value) {
          console.dir(value)
        })
      } else {
        console.log('WTF')
      }
    }
  })
  console.log('Mails aliases: ' + mailCount)
})


api.methodCall('domain.forward.list', [apikey, domain], function (error, value) {
  value.forEach(function (line) {
    alias[line.source] = line.destinations[0]
  })
  fs.createReadStream('mails.csv').pipe(parser)
})

