#!/bin/bash

USERID=$(id -u)                         # to find the user details
LOGS_FOLDER="/var/log/shell-roboshop"   # to send the logs to a particular location/folder
LOGS_FILE="$LOGS_FOLDER/$0.log"         # logs file name

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


check_root(){
    if [ $USERID -ne 0 ]; then
        echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
        exit 1
    fi
}