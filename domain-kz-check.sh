#/bin/bash
# Author: Yevgeniy Goncharov aka xck, http://sys-admin.kz

# Variables
# --------------------------------------------------
_hosterLink="https://www.ps.kz/domains/whois?domain="
_domain=$1
FLAG=$2


# Checking process
# --------------------------------------------------
function checkName(){

	check=`curl -s $_hosterLink$_domain | grep text-danger | sed 's/<\/\?[^>]\+>//g' | sed -r 's/&nbsp;/ /g' | awk '{$2=$2};1'` &>/dev/null

	# Check empty string -z or not -n
	if [[ -z $check ]]; then
		#statements
		echo "Домен свободен"
	else
		# Check flag
		if [[ -z $FLAG ]]; then
			echo $check
		else
			curl -s $_hosterLink$_domain | sed -n '/<table/,/<\/table>/p' | sed 's/<\/\?[^>]\+>//g' | sed -r 's/&nbsp;/ /g; s/ \+//g; /^\s*$/d; ' | awk '{$2=$2};1' > t.log

			while read -r line; do
		    	echo $line
			done < t.log

		fi
	fi
}


# Check run arguments
# ---------------------------------------------------\
#if [ $# -ne 1 ]; then

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Необходимо указать имя домена, пример: ./domain-kz-check.sh domain.local"
	exit 1
else
	checkName
fi


# обе команды делаюь одно и то же - убираем теги b, убираем все остальные теги, убираем пустые строки, убираем двойные пробелы
# cat test.html | sed 's|</b>|-|g' | sed 's|<[^>]*>||g' | awk 'NF' | awk '{$2=$2};1'
# cat test.html | sed 's|</b>|-|g; s|<[^>]*>||g; /^\s*$/d; s/ \+//g'
