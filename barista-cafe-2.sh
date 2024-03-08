#!/bin/bash

sudo apt update && apt install apache2 unzip wget -y

wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip

sudp systemctl start apache2
sudp systemctl enable apache2

unzip 2137_barista_cafe.zip

sudo cp -rf 2137_barista_cafe/* /var/www/html

sudo systemctl restart apache2
