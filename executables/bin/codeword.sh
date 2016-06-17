#!/bin/bash

w1=`randomword.sh | tr [:lower:] [:upper:]`
w2=`randomword.sh | tr [:lower:] [:upper:]`
echo ${w1} ${w2}
