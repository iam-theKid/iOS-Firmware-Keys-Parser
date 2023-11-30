#!/usr/bin/env sh
#!/bin/bash

# Change the current working directory
cd "`dirname "$0"`"
home=$(pwd)
os=$(uname)

read -p "Insert iOS version (blank to use BuildId) (ex. 14.3): " iosVersion
if [[ $iosVersion == "" ]]; then read -p "Insert iOS Build Id: " ipswbuildid ; fi
if [[ $iosVersion == "" ]] && [[ $ipswbuildid == "" ]]; then read -p "Need iOS version or iOS Build Id to continue, please start over." ; exit ; fi
read -p "Insert Device Id (ex. iPad7,6): " deviceId
while [[ $deviceId == "" ]]; do read -p "Insert Device Id (ex. iPad7,6): " deviceId; done

if [[ $iosVersion == "" ]]; then
    iosVersion=$(curl -sL "https://api.ipsw.me/v4/device/$deviceId?type=ipsw" | ./jq '.firmwares | .[] | select(.buildid=="'$ipswbuildid'") | .version' --raw-output)
fi
if [[ ! $ipswbuildid ]]; then 
    ipswbuildid=$(curl -sL "https://api.ipsw.me/v4/device/$deviceId?type=ipsw" | ./jq '.firmwares | .[] | select(.version=="'$iosVersion'") | .buildid' --raw-output)
fi

wikiSearch=$(echo "https://theapplewiki.com/index.php?search=%22""$ipswbuildid""+%28""$deviceId""%29%22&profile=advanced&fulltext=1&ns2304=1")
wikiPage=$(echo ""https://theapplewiki.com"$(curl -sl "$wikiSearch" | sed -n '/mw-search-result-heading/,/\<\/div\>/p' | sed -E -e 's/.*href=\"//' | sed -E -e 's/\".*|https.*//g' | grep / -m1)")
if [[ ! $(echo $wikiPage | grep 'Keys') ]]; then echo "iOS details not found! Please check the information provided!" ; sleep 2; echo "Exiting..."; sleep 2; exit ; fi

jsonKeysLink=$(echo ""https://theapplewiki.com"$(curl -sl "$wikiPage" | grep -o "/wiki/Special:Ask/-5B-5B-2DHas-20subobject::Keys:.*" | sed 's/\" title.*//')")
if [[ $jsonKeysLink == "https://theapplewiki.com" ]]; then read -p "Keys not availablefor this iOS...try a different one!" ; sleep 2; echo "Exiting..."; sleep 2; exit ; fi

read -p "Download json file?(y/n) :" downloadJson
if [[ $downloadJson == [y,Y] ]]; then curl -o "$deviceId"_"$ipswbuildid"_"$iosVersion.json" $jsonKeysLink; fi
echo "File saved as: $deviceId"_"$ipswbuildid"_"$iosVersion.json"

ibssiv=$(curl -sl "$wikiPage" | grep -o "keypage-ibss-iv.*" | sed 's/.*keypage-ibss-iv\"\>//' | sed 's/\<.*//')
ibsskey=$(curl -sl "$wikiPage" | grep -o "keypage-ibss-key.*" | sed 's/.*keypage-ibss-key\"\>//' | sed 's/\<.*//')
ibeciv=$(curl -sl "$wikiPage" | grep -o "keypage-ibec-iv.*" | sed 's/.*keypage-ibec-iv\"\>//' | sed 's/\<.*//')
ibeckey=$(curl -sl "$wikiPage" | grep -o "keypage-ibec-key.*" | sed 's/.*keypage-ibec-key\"\>//' | sed 's/\<.*//')
echo "iBSS and iBEC keys:\niBSS iv: $ibssiv\niBSS key: $ibsskey\niBEC iv: $ibeciv\niBEC key: $ibeckey\n"