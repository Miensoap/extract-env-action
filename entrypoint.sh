#!/bin/bash

SECRET_FILE=".mysecrets"

echo "$1" > "$SECRET_FILE"

secret() {
  local key="$1"
  local value=$(awk "/^$key<<EOF/{flag=1;next}/EOF/{flag=0}flag" "$SECRET_FILE")

  if [ -z "$value" ]; then
    echo "Key not found: $key" >&2
    return 1
  fi

  echo "$value"
}

alias secret=secret

eval "$2"
