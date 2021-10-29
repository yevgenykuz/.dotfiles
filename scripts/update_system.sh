#!/bin/bash
############################
#
# A simple updating script.
#
############################

echo -e "\e[91;1mUpdating System... \e[0m"
if [[ "$(uname -s)" == *[Dd]arwin* ]] 2>/dev/null; then # Darwin (MacOS)
  brew update;
  brew upgrade;
  brew cleanup;
else # Linux
  sudo sh -c 'apt-get update -y ; apt-get upgrade -y ; apt-get dist-upgrade -y ; \
  apt-get autoremove -y ; apt-get clean -y'
fi
echo -e "\e[92;1mDone ! \e[0m"
