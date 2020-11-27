#! /bin/bash

for package in $(jq '.devDependencies | to_entries[] | select( .value == @text "*") | .key' -r package.json)
do
    version=$(cat package-lock.json | jq ".dependencies.\"$package\".version" -r 2>/dev/null)
    if [ $? -ne 0 ]
    then
        echo "ERROR: SOMETHING IS WRONG WITH $package"
    else
        echo "$package:$version"
    fi
done
