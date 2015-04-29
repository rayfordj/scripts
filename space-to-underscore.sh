#!/bin/bash

# TODO: consider writing in a check for a directory argument to work against

for f in *
do
  new="${f// /_}"
  if [ "$new" != "$f" ]
  then
    if [ -e "$new" ]
    then
      echo Not renaming \""$f"\" because \""$new"\" already exists
    else
      echo Moving "$f" to "$new"
      mv "$f" "$new"
    fi
  fi
done


