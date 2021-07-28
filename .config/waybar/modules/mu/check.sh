#!/bin/sh
count=$(mu msgs-count --query='flag:unread AND NOT flag:trashed')
class=""

if [[ count -gt 0 ]]; then
  class="new"
fi

echo "{\"text\":\"\uf0e0 $count\",\"class\":\"$class\"}"
