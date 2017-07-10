#!/bin/bash
gradle="../gradlew"
[ "$(expr substr $(uname -s) 1 5)" == "MINGW" ] && gradle="../gradlew.bat"

for f in b*.gradle; do
    $gradle -b "$f" eclipse build 
done
