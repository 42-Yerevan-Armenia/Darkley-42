#!/bin/bash

dirs=("00-IDOR" "01-Open Redirect" "02-Insecure Cookie Handling" "03-HTTP Header Manipulation" "04-Value Manipulation" "05-Mime Spoofing" "06-Hidden Files Scraping" "07-Brute Force" "08-Dir Access Attack" "09-Restrict access" "10-SQL Injection of Image" "11-SQL Injection of User" "12-Stored XSS" "13-Reflected XSS")

for dir in "${dirs[@]}"; do
    mkdir -p "$dir/Ressources"
    touch "$dir/flag"
    echo "# $dir - Resources" > "$dir/Ressources/README.md"
    echo "This directory contains resources for the $dir vulnerability." >> "$dir/Ressources/README.md"
done

echo "Directories, 'flag' files, 'Ressources' directories, and 'README.md' files have been created successfully."
