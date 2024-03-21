#!/bin/bash

if [ $# -eq 0 ]; then
        echo "Error: You need to supply a filename with LinEnum.sh output"
        echo "Usage: bash <scriptname> <linenum-outputfile>"
        exit
fi

function checkGTFOBins(){
echo "Executing script..."
filename=$1
echo "Reading from input file: $filename"

binariesfound="/$HOME/binariesfound.txt"
touch $binariesfound

## Get all SUID binaries
sed -n '/SUID/,/SGID/p' $filename | awk '{ print $9}' | cut -d'/' -f3 | grep -v -e 'bin' -e 'sbin' | xargs -n1 echo > $binariesfound
sed -n '/SUID/,/SGID/p' $filename | awk '{ print $9}' | cut -d'/' -f4 | grep -v -e 'bin' -e 'sbin' | xargs -n1 echo >> $binariesfound

## Get all SGID binaries
sed -n '/SGID/,/rhost/p' $filename | awk '{ print $9}' |  cut -d'/' -f3 | grep -v -e 'bin' -e 'sbin' | xargs -n1 echo >> $binariesfound
sed -n '/SGID/,/rhost/p' $filename | awk '{ print $9}' |  cut -d'/' -f4 | grep -v -e 'bin' -e 'sbin' | xargs -n1 echo >> $binariesfound


cat $binariesfound | while read line
do
newurl=$line

curlurl=https://gtfobins.github.io/gtfobins/${line}/


if curl -o /dev/null -f -s $curlurl \
  -H 'authority: gtfobins.github.io' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: max-age=0' \
  -H 'referer: https://gtfobins.github.io/' \
  -H 'sec-ch-ua: "Chromium";v="103", ".Not/A)Brand";v="99"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.134 Safari/537.36' \
  --compressed \
  --insecure 

then echo "GTFOBins request successful for: $newurl"
else echo -n ""
fi
done
}

checkGTFOBins $1
