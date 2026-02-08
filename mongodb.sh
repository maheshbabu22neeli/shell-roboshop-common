#!/bin/bash

source ./common-script.sh

check_root

cp mongodb.repo /etc/yum.repos/mongo.repo
VALIDATE $? "Copying Mongo Repo"