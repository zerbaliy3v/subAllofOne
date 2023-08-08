#/bin/bash
subfinder  -d $1 -o s1;
amass enum  -passive -norecursive -noalts -d $1 -o s2;
assetfinder $1 > s3 ;
curl -s "https://crt.sh/?q=%25.$1&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u > s4;

cat s1 s2 s3 s4 | anew subdomain && rm -rf s1 s2 s3 s4;

cat subdomain | httpx -o live-subdomain;

