#!/bin/bash

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

host=10.10.10.10 # CHANGE THIS
password=Password # CHANGE THIS
port=3306 # CHANGE THIS

tables=(
    table1 # CHANGE THIS
    table2 # CHANGE THIS
    table3 # CHANGE THIS
)

printf -- '\033[37m#################################################################################### \033[0m\n';
printf -- '\033[37m################################# MIGRATION START ################################## \033[0m\n';
printf -- '\033[37m#################################################################################### \033[0m\n';
printf -- '\n';
printf -- '\033[32m Downloading backup to ~/backups...  \033[0m\n';
printf -- '\n';
# Download last backup over scp
scp user@10.10.10.10://pat_to_mysl_backup/sql_backup*.sql.tar.gz ~/local_backup/ # CHANGE THIS
printf -- '\033[32m Downloaded!!!  \033[0m\n';
printf -- '\n';

printf -- '\033[37m################################## DUMP TABLES ##################################### \033[0m\n';
printf -- '\n';

for i in "${tables[@]}"; do
	printf -- '\033[32m Running sed in %s scheme and data...  \033[0m\n' $i;
	#confirm
    ## INDEX AUTO INCREMENT FIX -- REMOVE THIS
	pv *_scheme_$i.sql|sed -r 's/AUTO_INCREMENT=[0-9]+/AUTO_INCREMENT=1/g' > $i.scheme_increment.sql
	pv *_data_$i.sql|sed -e "s/([0-9]*,/(NULL,/gi" > $i.null_good.sql 
	printf -- '\033[32m Loading %s scheme and data...  \033[0m\n' $i;
	#confirm
	pv $i.scheme_increment.sql|mysql -u user --password=$password -h $host -P $port DDBB_NAME
	#confirm
	pv $i.null_good.sql|mysql -u user --password=$password -h $host -P $port DDBB_NAME
	printf -- '\033[32m %s loaded!!!  \033[0m\n' $i;
	printf -- '\n';
done

printf -- '\033[37m#################################################################################### \033[0m\n';
printf -- '\033[37m################################# MIGRATION END #################################### \033[0m\n';
printf -- '\033[37m#################################################################################### \033[0m\n';

exit