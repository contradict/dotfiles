#!/bin/bash

port=1111
hostname=`hostname`

ssh -f $1 "nc -w 1 $hostname $port < $2"
nc -w 1 -l $port > $3
