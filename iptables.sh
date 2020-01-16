#!/bin/bash

confirm() {
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

add_port()
{
    iptables-save > /home/$SUDO_USER/tmp
    awk -v user=$SUDO_USER -v port=$PORT 'FNR==NR{ if (/-A INPUT/) p=NR; next} 1; FNR==p{ print "-A INPUT -p tcp -m tcp --dport "port" -m comment --comment \""user" reverse tcp\" -j ACCEPT"}' /home/$SUDO_USER/tmp /home/$SUDO_USER/tmp > /home/$SUDO_USER/tmp.tmp && mv /home/$SUDO_USER/tmp.tmp /home/$SUDO_USER/tmp
    iptables-restore < /home/$SUDO_USER/tmp
}

restore()
{
    grep -vwE "($SUDO_USER.*$PORT|$PORT.*$SUDO_USER)" /home/$SUDO_USER/tmp > /home/$SUDO_USER/tmp.tmp && mv /home/$SUDO_USER/tmp.tmp /home/$SUDO_USER/tmp
    iptables-restore < /home/$SUDO_USER/tmp
}

help() 
{
    printf --  "\n"
    printf --  "usage: $0 [-arh] [-p port]\n"
    printf --  "  -a      add rule\n"
    printf --  "  -r      restore tmp's rules in your home\n"
    printf --  "  -p      port\n"
    printf --  "  -h      display this help\n"
}


RESTORE=0
ADD=0
PORT=""

printf '\n';
printf '\033[1;32m################################# IPTABLES LOADER ################################## \033[0m\n';
printf '\n';

for arg in "$@"
do
    case $arg in
        -a|--add)
        	ADD=1
        	shift
        ;;
        -h|--help)
        	help
        	exit 0
        ;;
        -r|--restore)
        	RESTORE=1
        	shift
        ;;
        -p|--port)
        	PORT="$2"
        	shift
        	shift
        ;;
        -?*)
        	printf '\033[1;31mWARN: Unknown option (ignored): %s\n \033[0m\n' "$1" >&2
        	help
        	exit 0
        ;;
    esac
done

if [ $ADD == 1 ]; then	
	if [ -z "$PORT" ]; then
		printf '\033[1;31mWARN: Missing Port %s\n \033[0m\n' "$1" >&2
	else
		printf '\033[1;32m You will add port %s for user %s \n \033[0m\n' "$PORT" "$SUDO_USER">&2
		confirm
		add_port
		exit 0
	fi
fi

if [ $RESTORE == 1 ]; then	
	if [ -z "$PORT" ]; then
		printf '\033[1;31mWARN: Missing Port %s\n \033[0m\n' "$1" >&2
	else
		printf '\033[1;32m You will restore port %s for user %s \n \033[0m\n' "$PORT" "$SUDO_USER">&2
		confirm
		restore
		exit 0
	fi
fi

exit 0