# docker-gandi-mail
[![Docker pull](https://img.shields.io/docker/pulls/nouchka/gandi-mail)](https://hub.docker.com/r/nouchka/gandi-mail/)
[![Docker stars](https://img.shields.io/docker/stars/nouchka/gandi-mail)](https://hub.docker.com/r/nouchka/gandi-mail/)
[![Docker Automated buil](https://img.shields.io/docker/automated/nouchka/gandi-mail.svg)](https://hub.docker.com/r/nouchka/gandi-mail/)
[![Build Status](https://img.shields.io/travis/com/nouchka/docker-gandi-mail/master)](https://travis-ci.com/github/nouchka/docker-gandi-mail)
[![Docker size](https://img.shields.io/docker/image-size/nouchka/gandi-mail/latest)](https://hub.docker.com/r/nouchka/gandi-mail/)

Docker image for email aliases creation in Gandi.net

# How to

Create a .env file base on template env.template and complete with your gandi API key

Complete mails.csv file with first column alias, second column the target email

Run docker-compose up

Alias without target email will be deleted, Alias with different target email will be updated, new Alias will be created
