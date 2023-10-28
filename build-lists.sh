#!/bin/bash

country_code="us"
ripe_api_url="https://stat.ripe.net/data/country-resource-list/data.json?v4_format=prefix&resource=${country_code}"

json_file="$PWD/ripe-list.json"

country_codes_file="$PWD/country-codes.txt"
junos_us_list="$PWD/junos-list_US.txt"

# Check that curl exists
# https://github.com/curl/curl
if ! type curl > /dev/null; then
    echo "Install curl"
    exit 1
fi

# Check that jq exists
# https://github.com/jqlang/jq
if ! type jq > /dev/null; then
    echo "Install jq"
    exit 1
fi

if [ ! -f "$country_codes_file" ]; then
    # shellcheck source=./update-country-codes.sh
    source "$PWD/update-country-codes.sh"
fi

# If the file doesn't exist, or its modify date is more than 33 days ago, download it
if ! [ -f "$json_file" ] || (( $(date -r "$json_file" +%s) < $(date -d '33 days ago' +%s) ))
then
    curl -L -o "$json_file" "$ripe_api_url"
else
    # File up-to-date. Transform for Junos.
    
    # Reset junos_us_list
    if [ -f "$junos_us_list" ]; then
        rm "$junos_us_list"
    fi
    echo "Creating Junos US IP List"
    touch "$junos_us_list"

    ipv4_arr=$(jq -r '.data.resources.ipv4' "$json_file" | tr -d '[],"')
    for i in "${ipv4_arr[@]}"
    do
        echo "$i" >> "$junos_us_list"
    done

    # Done
    exit 0
fi