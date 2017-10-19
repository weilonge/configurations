#!/bin/bash

for a in `grep ^[^@#] .gitworking`; do git show $a --no-patch;done


