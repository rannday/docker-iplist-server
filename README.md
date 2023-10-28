# docker-iplist-server
Create a darkhttpd Docker to serve a downloaded RIPE IP list  

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