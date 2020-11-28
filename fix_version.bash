#! /bin/bash

for package in $(jq '.devDependencies | to_entries[] | select( .value == @text "*") | .key' -r package.json)
do
    version=$(cat package-lock.json | jq ".dependencies.\"$package\".version" -r 2>/dev/null)
    if [ $? -ne 0 ]
    then
        echo "ERROR: SOMETHING IS WRONG WITH $package"
    else
        cp package.json /tmp/temp.package.json
        echo "$package:$version"
        cat /tmp/temp.package.json | jq ".devDependencies.\"$package\" = \"$version\"" -r > package.json
    fi
done
