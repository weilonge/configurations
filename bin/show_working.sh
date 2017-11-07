#!/bin/bash

for a in `grep ^[^@#] .gitworking | awk '{print $1}'`; do git show $a --no-patch;done


