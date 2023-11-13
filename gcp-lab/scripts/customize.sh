#!/bin/bash

echo "***** Setup nginx *****"

local_ip=$(hostname -I | cut -d' ' -f1)

system_hostname=$(hostname)

sudo sed -i "s/\(hostname:\) replace_1/\1 $system_hostname/; s/\(ip:\) replace_2/\1 $local_ip/" /var/www/html/index.html

echo "*****   Setup Completed!!   *****"