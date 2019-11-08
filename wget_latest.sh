#!/bin/bash

#-------------------------------------------------------------------------------------------------------

download () {
    # example URLs
    #https://github.com/Jmainguy/k8sCapcity/releases/download/v0.1.2/k8sCapcity_Darwin_x86_64.tar.gz
    #https://github.com/Jmainguy/k8sCapcity/releases/download/v0.1.2/k8sCapcity_Linux_x86_64.tar.gz

    plat="$1"
    line="$2"

    [ "$plat" == "macos" ] && os="Darwin" || os="Linux"

    echo "OS: $plat -- ${line}/releases/latest"

    odir="artifacts/$plat"
    basename=$(echo "$line" | awk -F/ '{print $NF}')
    tball="${basename}_${os}_x86_64.tar.gz"
    mkdir -p $odir && (cd $odir; curl -sLC - -O "${line}/releases/latest/download/$tball")
    file "$odir/$tball" | grep -q 'gzip compressed data' && \
        tar zxvf "$odir/$tball" --exclude={LICENSE,README*} -C $odir/
}

#-------------------------------------------------------------------------------------------------------

while read -r line; do

    download "macos" "$line"
    download "linux" "$line"

    find . -name "*.gz" -delete

done < <(grep -E 'git|http' .meta  | awk -F': "' '{print $2}' | sed 's/".*$//')

bundleDir="artifacts/bundles"
mkdir -p $bundleDir
tar -C artifacts/linux/ -zcvf $bundleDir/opsMarina_Linux_x86_64.tar.gz .
tar -C artifacts/macos/ -zcvf $bundleDir/opsMarina_Darwin_x86_64.tar.gz .

exit 0
