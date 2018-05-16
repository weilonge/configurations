#!/bin/bash

cd gitPlayground/

rebase_working.sh

echo "Hello World\! my friends
Hello there" > README
git add README
git rebase --continue

rebase_working.sh

