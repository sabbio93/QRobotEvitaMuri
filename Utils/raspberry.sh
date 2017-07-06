#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Inserire il nome di una cartella"
    exit 0
fi

projectName="$1"
ctxRover="it.unibo.ctxRover.MainCtxRover-1.0"
workspace="/tmp/"
tarname="$ctxRover.tar"



git pull
cd "$projectName"
gradle -b build_ctxRover.gradle build
tar -xvf "build/distributions/$tarname" -C $workspace
java -jar "$workspace$ctxRover/$projectName-1.0.jar"
