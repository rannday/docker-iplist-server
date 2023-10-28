#!/bin/bash
# shellcheck disable=SC2001

csv_file="$PWD/export.csv"

if [ ! -f "$csv_file" ]; then
    echo "Download the CIA file. Exiting."
    exit 1
fi

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

done < "$csv_file"