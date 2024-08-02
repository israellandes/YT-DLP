#!/bin/bash

# Read each line from stdin
while IFS= read -r line; do
    # Count the number of forward slashes
    slash_count=$(echo "$line" | tr -cd '/' | wc -c)
    
    # If the count is greater than 3, print the line
    if [ "$slash_count" -gt 3 ]; then
        echo "$line"
    fi
done

