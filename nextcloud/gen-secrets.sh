#!/bin/sh
# Simple script to generate secrets
TO_GENERATE="database user password"

generatePassword() {
    openssl rand -hex 12
}

echo "Initialize database access"
echo "Do you want random access ? [Y/n]"
read ANSWER


if [ -z $ANSWER ] || [ $ANSWER = 'Y' ]
then
	for VARIABLE in $TO_GENERATE ; do
        	echo $(generatePassword) > $(dirname "$0")/secrets/mysql-${VARIABLE}.txt
	done
	echo "Database secrets initialized whit random data"
else 
	echo "What is your database name ?"
	read DATABASE
	echo $DATABASE > $(dirname "$0")/secrets/mysql-database.txt
	echo "What is your database user ?"
	read USER
	echo $USER > $(dirname "$0")/secrets/mysql-user.txt
	echo "User password ?"
	read PASSWORD
	echo $PASSWORD > $(dirname "$0")/secrets/mysql-password.txt
	echo "Database secrets initialized whit your access"
fi
