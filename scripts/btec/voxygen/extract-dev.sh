#!/bin/bash
set -e

filename=data/raw/btec.fr-en/btec-dev-concat.fr
dir=data/raw/btec.fr-en/speech_fr/dev-concat

mkdir -p ${dir}
lines=`wc -l ${filename} | cut -d' ' -f1`

for i in `seq 1 ${lines}`;
do
    num=`printf "%04d" ${i}`
    cat ${filename} | sed -n "${i},${i}p" > ${dir}/${num}.txt
    scripts/btec/voxygen/wsclient_fixed.py -i ${dir}/${num}.txt -o ${dir}/${num}.wav header=wav-header frequency=16000 coding=lin
    rm ${dir}/${num}.txt
done