#!/bin/bash

# The name of the file that contains the list of hostname and IP addresses
file="res"

# Use awk to extract the IP addresses from the file
ip_addresses=$(awk '{print $2}' "$file")

# Save the extracted IP addresses to a file
echo "$ip_addresses" > ip_addresses.txt

# subfinder -d tesla.com > res
# ./test.sh