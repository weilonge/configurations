#!/bin/bash

set -e

cd gitPlayground/

set +e
git ow rebase
set -e

echo "Hello World\! my friends
Hello there" > README
git add README
git rebase --continue

git ow rebase

