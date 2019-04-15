#!/bin/bash
aws ec2 describe-instances --output text \
    --query 'Reservations[*].Instances[*].{
             aIP:PrivateIpAddress,
             bHostname:(Tags[?Key==`Hostname`].Value)[0],
             cID:InstanceId,
             dState:State.Name,
             eRole:IamInstanceProfile.Arn}'
