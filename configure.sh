#!/bin/bash

cmake -S . -B build
cmake -S test/ -B build/test
cmake -S test/ -B build/gui
find . -iname "compile_commands.json" | xargs jq -s 'map(.[])' > output.json
