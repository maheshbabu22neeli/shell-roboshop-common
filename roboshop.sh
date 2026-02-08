#!/bin/bash

DOMAIN_NAME="neeli.online"

SG_ID="sg-09b115c1d01c0b270"
AMI_ID="ami-0220d79f3f480ecf5"
INSTANCE_TYPE="t3.micro"
ROUT53_HOSTED_ZONE_ID="Z013175831RO1NWFBESW7"

for instance in "$@"
do
  EC2_INSTANCE_ID=$( aws ec2 run-instances \
      --image-id $AMI_ID \
      --instance-type $INSTANCE_TYPE \
      --security-group-ids $SG_ID \
      --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance},
          {Key=Environment,Value=learning}]" \
      --query 'Instances[0].InstanceId' \
      --output text )

  if [ $instance == "frontend" ]; then
      IP=$(
          aws ec2 describe-instances \
          --instance-ids $EC2_INSTANCE_ID \
          --query 'Reservations[].Instances[].PublicIpAddress' \
          --output text
      )
      RECORD_NAME="$DOMAIN_NAME" # neeli.online
  else
      IP=$(
          aws ec2 describe-instances \
          --instance-ids $EC2_INSTANCE_ID \
          --query 'Reservations[].Instances[].PrivateIpAddress' \
          --output text
      )
      RECORD_NAME="$instance.$DOMAIN_NAME" # mongodb.neeli.online
  fi

  echo "IP Address: $IP"

  aws route53 change-resource-record-sets \
  --hosted-zone-id $ROUT53_HOSTED_ZONE_ID \
  --change-batch '
  {
    "Comment": "Updating record",
    "Changes": [
      {
      "Action": "UPSERT",
      "ResourceRecordSet": {
          "Name": "'$RECORD_NAME'",
          "Type": "A",
          "TTL": 1,
          "ResourceRecords": [
          {
              "Value": "'$IP'"
          }
          ]
        }
      }
    ]
  }
  '

  echo "record updated for $instance"

done