# docker-iplist-server
Create a darkhttpd Docker to serve a downloadable IP list  

Right, it just creates a list of IPv4 US addresses. The list is pulled from RIPE.  

Clone repo - `git clone https://github.com/rannday/docker-iplist-server` and `cd docker-iplist-server`  
Build image - `docker build . -t iplists:latest`  
Maybe change networking IP bindings in the compose file  
Start compose - `docker compose up -d`  

I have caddy installed on the server so I bind the server's IP to 9001 in the compose file (e.g. `192.168.100.10:9001:9001/tcp`), and proxy 9001 to a domain with the Caddyfile. Caddy takes care of create a cert and keeping it updated, just have ports 80/tcp and 443/tcp opened up.

```
sub.domain.tld {
    reverse_proxy 192.168.100.10:9001
}
```

### Junos config on a SRX  
```
set security dynamic-address feed-server server_name url sub.domain.tld
set security dynamic-address feed-server server_name update-interval 86400
set security dynamic-address feed-server server_name hold-interval 90000
set security dynamic-address feed-server server_name feed-name basic-us path /basic-us.txt
set security dynamic-address address-name default-allow profile feed-name basic-us
```
### Example policy entry  
```
set security policies from-zone untrust to-zone trust policy permit-app match source-address default-allow
```

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