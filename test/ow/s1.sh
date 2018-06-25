#!/bin/bash

set -e

rm -rf gitPlayground
mkdir gitPlayground
cd gitPlayground/

echo "test_1
test_2 test_1" > .gitow

git init

echo "Hello World\!" > README
git add README
git commit -am "init commit"

echo "Hello there" >> README
git commit -am "2nd commit."

git checkout -b test_1
echo "Hello World\! my friends
Hello there" > README
git commit -am "branch test_1"

git checkout master
echo "Hello World\! my family
Hello there" > README
git commit -am "3rd commit."
echo "Hello World\! every family
Hello there" > README
git commit -am "4th commit."

git checkout test_1
git checkout -b test_2
echo "Hello World\! my friends and family
Hello there" > README
git commit -am "test_2.1"

echo "Hello World\! my friends, family and colleagues.
Hello there" > README
git commit -am "test_2.2"

