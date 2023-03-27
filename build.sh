#!/usr/bin/bash

ls *.md | sed 's/\.md//g' | awk '{ print "["$0"]("$0".html)" }' >index.md

rm -r .output

git clone --branch gh-pages git@github.com:Vobludalib/linux-lab-testing.git .output

for MD in *.md; do (
    FILE=${MD%.*}.html
    pandoc --standalone --template template.html $MD >.output/$FILE
) done

DATE="$(date '+%Y-%m-%d %H:%M:%S')"

echo $DATE

cd .output
git add *.html
git commit -m "Changed page ( $DATE )"
git push origin gh-pages