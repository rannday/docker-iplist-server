# docker-iplist-server
Create a darkhttpd Docker to serve a downloadable IP list  

Right now, it just creates a list of IPv4 US addresses. The list is pulled from RIPE.  
Docker image size - 7.41MB!  

1. Clone repo - `git clone https://github.com/rannday/docker-iplist-server` and `cd docker-iplist-server`  
2. Build image - `docker build . -t iplists:latest`  
3. Maybe change networking IP bindings in the compose file  
4. Start compose - `docker compose up -d`  

## RIPE
Pulls from the RIPE API with curl    
https://stat.ripe.net/docs/02.data-api/country-resource-list.html
## Country Codes
[CIA World Factbook Country Codes](https://www.cia.gov/the-world-factbook/references/country-data-codes/)  
Place in the /lists-src directory
## TO-DO
* Make it work for all supported country codes from RIPE.