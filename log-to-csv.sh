#!/bin/bash
# Sed-Commando voor het converteren van Apache W3C Logformat naar CSV

sed \
-e 's/^/"/' \
-e 's/ \([^ ]\{1,\}\) \([^ ]\{1,\}\) \[\([0-9]\{1,2\}\)\/\([a-zA-Z]\{1,3\}\)\/\([0-9]\{1,4\}\):/" "\1" "\2" "\3.\4 \5 /' \
-e 's/ +0200\] /" /' \
-e 's/\([^" ]\)"\([^" ]\)/\1""\2/g'
