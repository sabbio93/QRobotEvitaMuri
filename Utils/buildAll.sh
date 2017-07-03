#!/bin/bash
gradle="gradlew"
[ "$(expr substr $(uname -s) 1 5)" == "MINGW" ] && gradle="gradlew.bat"
for d in ../Model* ; do
	for f in $d/b*.gradle; do
        $gradle -b "$f" clean eclipse build
    done
done
