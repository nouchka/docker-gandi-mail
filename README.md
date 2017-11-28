# docker-gandi-mail
Docker image for email aliases creation in Gandi.net

# How to

Create a .env file base on template env.template and complete with your gandi API key

Complete mails.csv file with first column alias, second column the target email

Run docker-compose up

Alias without target email will be deleted, Alias with different target email will be updated, new Alias will be created
