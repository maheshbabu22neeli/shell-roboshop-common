#!/bin/bash

USERID=$(id -u)                         # to find the user details
LOGS_FOLDER="/var/log/shell-roboshop"   # to send the logs to a particular location/folder
LOGS_FILE="$LOGS_FOLDER/$0.log"         # logs file name

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p $LOGS_FOLDER

echo "$(date "+%Y-%m-%d %H:%M:%S") | Script started executing at: $(date)" | tee -a $LOGS_FILE

check_root(){
    if [ $USERID -ne 0 ]; then
        echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $2 ... $R FAILURE $N" | tee -a $LOGS_FILE
        exit 1
    else
        echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $2 ... $G SUCCESS $N" | tee -a $LOGS_FILE
    fi
}