#!/bin/bash
apt-get update && apt-get install nginx -y
echo "Hello. This is NGINX web server installed via Azure custom extension" > /var/www/html/index.html
