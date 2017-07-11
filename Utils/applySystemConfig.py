#!/usr/bin/python

import sys

if(len(sys.argv)<=1):
    print "Usage: python applySystemConfig <configuration>"
    sys.exit(0)

configuration = sys.argv[1].lower()
yamlFile = "../Utils/contextConfig.yaml"

# Read in the file
import yaml
import re

# load yaml configuration
with open(yamlFile, 'r') as stream:
    try:
        contexts = yaml.load(stream)[configuration]
        print(contexts)
    except yaml.YAMLError as exc:
        print(exc)

import fnmatch
import os

def modifyFileWithContext(file):
    with open(file, 'r') as fin:
        filedata = fin.read()
        print filedata

    for context in contexts:
        nome =  context.lower()
        addr = contexts[context]['host']
        port = contexts[context]['port']
        print nome, addr, port, " <--- ", context

        regex= r'context\({0}, .*\)'.format(nome)
        replaced= 'context({0}, "{1}",  "TCP", "{2}" )'.format(nome, addr, port)

        cerca = re.search(regex, filedata)
        print "Regex: ", regex, replaced, cerca

        # Set the new value for context
        filedata = re.sub(regex, replaced, filedata)

    # Write the file out again
    with open(file, 'w') as fout:
        fout.write(filedata)

# write in each file model*.pl in srcMore le posizioni dei contesti
for root, dirnames, filenames in os.walk('srcMore'):
    for filename in fnmatch.filter(filenames, 'm*.pl'):
        modifyFileWithContext(os.path.join(root, filename))
