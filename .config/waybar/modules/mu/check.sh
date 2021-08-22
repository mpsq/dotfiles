#!/bin/sh
count=$(mu msgs-count --query='flag:unread AND NOT flag:trashed')

if [[ count -gt 0 ]]; then
  echo "{\"text\":\"\uf0e0 $count\",\"class\":\"new\"}"
else
  echo "{\"text\":\"\"}"
fi

