#!/bin/sh -l

echo "$1" | while read -r line; do
  if [[ ! -z "$line" && "$line" != \#* ]]; then  
    key=$(echo $line | cut -d '=' -f 1)
    value=$(echo $line | cut -d '=' -f 2-)

    echo "$key=$value" >> $GITHUB_ENV
    echo "::add-mask::$value"
    echo "Setting environment variable: $key"
  fi
done
