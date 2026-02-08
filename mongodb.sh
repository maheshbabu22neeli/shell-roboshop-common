#!/bin/bash

source ./common-script.sh

check_root

cp mongo.repo /etc/yum.repos/mongo.repo
VALIDATE $? "Copying Mongo Repo"