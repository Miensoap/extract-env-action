#!/bin/bash

SECRET_FILE="$GITHUB_WORKSPACE/.mysecrets"

echo "$1" > "$SECRET_FILE"

secret() {
  key="$1"
  value=""

  if grep -q "^${key}<<EOF" "$SECRET_FILE"; then
    value=$(awk "/^$key<<EOF/{flag=1;next}/EOF/{flag=0}flag" "$SECRET_FILE")
  else
    value=$(grep "^$key=" "$SECRET_FILE" | cut -d '=' -f2-)
  fi

  if [ -z "$value" ]; then
    echo "Key not found: $key" >&2
    return 1
  fi

  echo "$value"
}

echo "$(declare -f secret)" >> "$GITHUB_ENV"
