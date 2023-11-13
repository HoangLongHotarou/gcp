#!/bin/bash
echo "***** Setup HTML *****"

mkdir -p /var/www/html
chmod 777 /var/www/html
cd /tmp && unzip html5up.zip
mv html5up/* /var/www/html
# echo "Hello world: account name: longvdh3, hostname: replace_1,  ip: replace_2" > /var/www/html/index.html

echo "*****   Setup Completed!!   *****"