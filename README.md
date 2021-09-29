# docker-gandi-mail
[![Docker pull](https://img.shields.io/docker/pulls/nouchka/gandi-mail)](https://hub.docker.com/r/nouchka/gandi-mail/)
[![Docker stars](https://img.shields.io/docker/stars/nouchka/gandi-mail)](https://hub.docker.com/r/nouchka/gandi-mail/)
[![Build Status](https://gitlab.com/japromis/docker-gandi-mail/badges/master/pipeline.svg)](https://gitlab.com/japromis/docker-gandi-mail/pipelines)
[![Docker size](https://img.shields.io/docker/image-size/nouchka/gandi-mail/latest)](https://hub.docker.com/r/nouchka/gandi-mail/)

Docker image for email aliases creation in Gandi.net

# How to

Create a .env file base on template env.template and complete with your gandi API key

Complete mails.csv file with first column alias, second column the target email

Run docker-compose up

Alias without target email will be deleted, Alias with different target email will be updated, new Alias will be created
