#!/bin/bash
#This script search in /root/frontend-static/dist and delete old files en each language.
FRONT="/root/frontend-static/dist/*"
for language in ${FRONT//:/ }; do
	dirname=$(basename $language)
	if [ $dirname != "mobile" ] 
	then
    	for bulk in ${language//:/ }/*; do
    		fname=$(basename $bulk)
    		fnamesuffix=${fname%%.*}
    		find $language/$fnamesuffix.* -mtime +30 -type f -exec rm {} \;
    	done
    fi
done
