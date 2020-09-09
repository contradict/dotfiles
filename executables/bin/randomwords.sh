#!/bin/bash 
 
# Random Word Generator 
# linuxconfig.org 
 
# Constants
X=0
ALL_NON_RANDOM_WORDS=/usr/share/dict/words

# total number of non-random words available
non_random_words=$(wc -l $ALL_NON_RANDOM_WORDS | cut -d' ' -f 1)

ENTROPY=$(echo "a=l(${non_random_words})/l(2);scale=0;a/1" | bc -l)

if [ $# -ne 1 ] 
then 
    echo "Please specify how many random words would you like to generate !" 1>&2
    echo "example: ./random-word-generator 3" 1>&2 
    echo "This will generate 3 random words" 1>&2 
    echo "Each words has ~${ENTROPY} bits of entropy" 1>&2
    exit 0
fi

randbytes=$(echo "a=(${ENTROPY}/8 + 1);scale=0;a/1" | bc)

# while loop to generate random words
# number of random generated words depends on supplied argument 
while [ "$X" -lt "$1" ] 
do 
    random_number=$(od -N"${randbytes}" -An -i /dev/urandom)
    random_index=$(echo "${random_number} * ${non_random_words} / 2^(${randbytes}*8)" | bc)
    sed "${random_index}q;d" $ALL_NON_RANDOM_WORDS
    let "X = X + 1" 
done
