# docker-iplist-server
Create a darkhttpd Docker to serve a downloaded RIPE IP list  
https://stat.ripe.net/docs/02.data-api/country-resource-list.html

## Junos
* Dynamic Addresses
  * https://www.juniper.net/documentation/us/en/software/junos/logical-system-security/topics/ref/statement/dynamic-address.html
* Feed Server
  * https://www.juniper.net/documentation/us/en/software/junos/security-policies/topics/ref/statement/security-dynamic-address-feed-server.html

## Country Codes
* To update codes, download from:
  * https://www.cia.gov/the-world-factbook/references/country-data-codes/  
* Place in the root of this project and run `./update-country-codes.sh`

## TO-DO
* Get docker going. 
* Make it work for all supported country codes from RIPE.