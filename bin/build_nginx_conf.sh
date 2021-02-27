#!/usr/bin/env bash

# Define the variables with values you want replaced
read -p "Enter Service Name: "    service
SERVICE_NAME=$service
read -p "Enter Server Name/IP: "  server_name
SERVER_NAME=$server_name
# This could also be read in via bash arguments. 
# Google "bash getopts" for more information

# render a template configuration file
# expand variables + preserve formatting
# user="Venkatt"
# referenced inside the template.txt as $user
# render_template /path/to/template.txt > path/to/configuration_file
function render_template() {
  eval "echo \"$(cat $1)\""
}

function generate_httpd_conf {
  echo "#### Creating /etc/nginx/conf.d/$service.conf from template ./nginx.conf.tmpl"
  render_template nginx.conf.tmpl > /etc/nginx/conf.d/$service.conf
}
