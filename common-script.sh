#!/bin/bash

USERID=$(id -u)                         # to find the user details
LOGS_FOLDER="/var/log/shell-roboshop"   # to send the logs to a particular location/folder
LOGS_FILE="$LOGS_FOLDER/$0.log"         # logs file name

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir $LOGS_FOLDER

LOG_MESSAGE() {
  echo "$(date "+%Y-%m-%d %H:%M:%S") | $1 $2 $N" | tee -a $LOGS_FILE
}

check_root(){
    if [ $USERID -ne 0 ]; then
        echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
        exit 1
    fi
}

VALIDATE() {
  if ($1 ne 0) then
    LOG_MESSAGE $R $2
    exit 1
  else
    LOG_MESSAGE $G $2
  fi
}