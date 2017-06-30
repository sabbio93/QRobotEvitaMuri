#!/bin/bash
for filename in ./*.gradle; do
        gradle -b "$filename" clean eclipse build
    done
done
