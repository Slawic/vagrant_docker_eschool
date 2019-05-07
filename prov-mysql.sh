#!/bin/bash

ALL_PARAMS=3
BADPARAMS=65
MYSQL='5.7'

PAR1="CREATE DATABASE IF NOT EXISTS $1;"
PAR2="GRANT ALL ON *.* TO '$2'@'localhost' IDENTIFIED BY '$3';"
PAR3="FLUSH PRIVILEGES;"
SQLSENTENCE="${PAR1}${PAR2}${PAR3}"

if [ $# -ne $EXPECTED_ADRGS ]
then
  echo "used: $0 dbname dbuser dbpass"
  exit $BADPARAMS
fi

$MYSQL -uroot -p -e "$SQLSENTENCE"