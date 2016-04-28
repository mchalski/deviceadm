#!/bin/bash
lines=$(cat LICENSE | wc -l)

# failures=0
for each in $(find . \( -path ./vendor -o -path ./Godeps \) -prune -o -type f -name '*.go' -print); do
  echo "Checking $each for correct license header"
  head -n $lines $each | diff -qu LICENSE - > /dev/null
  if [ ! "$?" -eq "0" ]; then
    echo "Failed license check on $each"
    exit 1
  else
    echo "License check passed on $each"
  fi
done
