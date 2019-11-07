#!/bin/bash


#https://github.com/Jmainguy/k8sCapcity/releases/latest

while read -r line; do
    basename=$(echo "$line" | awk -F/ '{print $NF}')
    #https://github.com/Jmainguy/k8sCapcity/releases/download/v0.1.2/k8sCapcity_Darwin_x86_64.tar.gz
    #https://github.com/Jmainguy/k8sCapcity/releases/download/v0.1.2/k8sCapcity_Linux_x86_64.tar.gz

    echo "${line}/releases/latest"

    odir="artifacts/macos"
    tball="${basename}_Darwin_x86_64.tar.gz"
    mkdir -p $odir && (cd $odir; curl -sLC - -O "${line}/releases/latest/download/$tball")
    file "$odir/$tball" | grep -q 'gzip compressed data' && \
        tar zxvf "$odir/$tball" --exclude={LICENSE,README*} -C $odir/

    odir="artifacts/linux"
    tball="${basename}_Linux_x86_64.tar.gz"
    mkdir -p $odir && (cd $odir; curl -sLC - -O "${line}/releases/latest/download/$tball")
    file "$odir/$tball" | grep -q 'gzip compressed data' && \
        tar zxvf "$odir/$tball" --exclude={LICENSE,README*} -C $odir/

    #tar ztvf k8sCapcity_Linux_x86_64.tar.gz --exclude={LICENSE,README*}

done < <(grep -E 'git|http' .meta  | awk -F': "' '{print $2}' | sed 's/".*$//')

exit 0
