#!/bin/bash
FILE=`curl -s https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/ | grep 'linux.zip"' | tail -1 | cut -d '"' -f 2`
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/$FILE
unzip sonar-scanner-cli-*.zip -d sonar-scanner-cli
rm -f sonar-scanner-cli-*.zip
ln -s /root/sonar-scanner-cli/bin/sonar-scanner /usr/bin/sonar-scanner
ln -s /root/sonar-scanner-cli/bin/sonar-scanner-debug /usr/bin/sonar-scanner-debug