#!/bin/bash

# Function to print the ASCII art header
print_header() {
    echo -e "\n \n"
    echo -e " _       __     __   _____ __        __"
    echo "| |     / /__  / /_ / ___// /_____ _/ /___  _______"
    echo "| | /| / / _ \/ __ \\__ \/ __/ __ \`/ __/ / / / ___/"
    echo "| |/ |/ /  __/ /_/ /__/ / /_/ /_/ / /_/ /_/ (__  )"
    echo "|__/|__/\___/_.___/____/\__/\__,_/\__/\__,_/____/"
    echo -e "\n                                -Infinity  \n"
    echo -e "                                     \n"
    echo "       "
}

# Function to check URL accessibility
check_url_accessibility() {
    local url=$1
    local status_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    
    case $status_code in
        200)
            echo "URL $url is accessible. Status code: $status_code"
            ;;
        302)
            echo "URL $url is temporarily redirected. Status code: $status_code"
            ;;
        401)
            echo "URL $url requires authentication. Status code: $status_code"
            ;;
        403)
            echo "URL $url is forbidden. Status code: $status_code"
            ;;
        500)
            echo "URL $url encountered an internal server error. Status code: $status_code"
            ;;
        *)
            echo "URL $url returned an unknown status code: $status_code"
            ;;
    esac
}

# Check if a file name is provided as an argument
if [[ $# -eq 0 ]]; then
    echo "Please provide the name of the file containing URLs."
    exit 1
fi

filename="$1"

# Check if the file exists
if [[ ! -f "$filename" ]]; then
    echo "File not found: $filename"
    exit 1
fi

# Print the ASCII art header and footer
print_header

# Read URLs from the file and check their accessibility
while read -r url; do
    check_url_accessibility "$url"
done < "$filename"
