#!/bin/bash


#https://github.com/Jmainguy/k8sCapcity/releases/latest

download () {
    # example URLs
    #https://github.com/Jmainguy/k8sCapcity/releases/download/v0.1.2/k8sCapcity_Darwin_x86_64.tar.gz
    #https://github.com/Jmainguy/k8sCapcity/releases/download/v0.1.2/k8sCapcity_Linux_x86_64.tar.gz

    plat="$1"
    basename="$2"

    [ "$plat" == "macos" ] && os="Darwin" || os="Linux"

    odir="artifacts/$plat"
    tball="${basename}_${os}_x86_64.tar.gz"
    mkdir -p $odir && (cd $odir; curl -sLC - -O "${line}/releases/latest/download/$tball")
    file "$odir/$tball" | grep -q 'gzip compressed data' && \
        tar zxvf "$odir/$tball" --exclude={LICENSE,README*} -C $odir/

    #tar ztvf k8sCapcity_Linux_x86_64.tar.gz --exclude={LICENSE,README*}

}

while read -r line; do
    basename=$(echo "$line" | awk -F/ '{print $NF}')

    echo "${line}/releases/latest"
    download "macos" "$basename"
    download "linux" "$basename"

done < <(grep -E 'git|http' .meta  | awk -F': "' '{print $2}' | sed 's/".*$//')

exit 0
