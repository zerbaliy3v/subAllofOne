#/bin/bash
subfinder  -d $1 -o s1 && amass enum  -passive -norecursive -noalts -d $1 -o s2 && assetfinder $1 > s3  && curl -s "https://crt.sh/?q=%25.$1&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u > s4;

#brute force
findomain -t $1  -w /usr/local/danielmiessler/SecLists/Discovery/DNS/subdomains-top1million-110000.txt --unique-output s5;

cat s1 | anew subdomain && cat s2 | anew subdomain && cat s3 | anew subdomain && cat s4 | anew subdomain && rm -rf s1 s2 s3 s4 s5;

cat s5 | anew subdomain;

cat subdomain | httpx -o live-subdomain;
