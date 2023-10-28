# docker-iplist-server
Create a darkhttpd Docker to serve a downloadable IP list  

Right, it just creates a list of IPv4 US addresses. The list is pulled from RIPE.  

Clone repo - `git clone https://github.com/rannday/docker-iplist-server` and `cd docker-iplist-server`  
Build image - `docker build . -t iplists:latest`  
Maybe change networking IP bindings in the compose file  
Start compose - `docker compose up -d`  

## RIPE
Pulls from the RIPE API with curl    
https://stat.ripe.net/docs/02.data-api/country-resource-list.html
## Junos
[Dynamic Addresses](https://www.juniper.net/documentation/us/en/software/junos/logical-system-security/topics/ref/statement/dynamic-address.html)    
[Feed Server](https://www.juniper.net/documentation/us/en/software/junos/security-policies/topics/ref/statement/security-dynamic-address-feed-server.html)
## Country Codes
[CIA World Factbook Country Codes](https://www.cia.gov/the-world-factbook/references/country-data-codes/)  
Place in the /lists-src directory

## TO-DO
* Make it work for all supported country codes from RIPE.