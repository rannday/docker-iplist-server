#!/bin/bash

# Will reset the lists directory if it already exists

country_code="us"

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

ripe_api_url="https://stat.ripe.net/data/country-resource-list/data.json?v4_format=prefix&resource=${country_code}"

lists="$PWD/lists"
lists_src="$PWD/lists-src"
ripe_file="$lists_src/ripe-list.json"
cia_file="$lists_src/export.csv"
country_codes_file="$lists_src/country-codes.txt"

us_basic_file="$lists/basic-us.txt"

if ! [ -f "$cia_file" ]; then
    echo "Download the CIA file. Exiting."
    exit 1
fi

if ! [ -f "$country_codes_file" ]; then
    echo "Updating country codes."

    # Name;GENC;ISO 3166;Stanag;Internet;Comment
    while IFS=";" read -r col_name col_genc col_iso col_stan col_int col_com
    do
        unset "$col_name" "$col_genc" "$col_stan" "$col_int" "$col_com"
        # Remove quotes
        str_iso=$(echo "$col_iso" | tr -d '"')
        # Split by | and get the first entry
        first_col=$(echo "$str_iso" | cut -d "|" -f 1)
        # Remove whitespace
        str_ws=$(echo "$first_col" | sed 's/ //g')
        
        # Write only codes to file
        if ! [ "$str_ws" = "ISO3166" ]; then
            if ! [ "$str_ws" = "-" ]; then
                echo "$str_ws" >> "$country_codes_file" 
            fi
        fi

    done < "$cia_file"
fi

# If the ripe file doesn't exist, or its modify date is more than 33 days ago, download it
if ! [ -f "$ripe_file" ] || (( $(date -r "$ripe_file" +%s) < $(date -d '33 days ago' +%s) ))
then
    curl -L -o "$ripe_file" "$ripe_api_url"
else
    # File up-to-date. Format it.

    # Reset the lists directory
    if [ -d "$lists" ]; then
        rm -rf "$lists"
    fi
    mkdir -p "$lists"

    # Basic - X.X.X.X/XX per line
    touch "$us_basic_file"

    ipv4_arr=$(jq -r '.data.resources.ipv4' "$ripe_file" | tr -d '[],"')
    for i in "${ipv4_arr[@]}"
    do
        echo "$i" >> "$us_basic_file"
    done

    gzip "$us_basic_file"

    # Done
    exit 0
fi