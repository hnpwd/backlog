#!/bin/sh

touch backlog.md
echo '| #    | COMMENT                                       | URL                                 | D | I | REMARKS         |' > tmp.md
echo '|------|-----------------------------------------------|-------------------------------------|---|---|-----------------|' >> tmp.md
#    '| 0001 | https://news.ycombinator.com/item?id=46618723 | https://jgc.org/                    | Y | Y |                 |'
                                             sfmt='| %s | %s |                                     |   |   |                 |'
n=1
while read -r id
do
    sno=$(printf '%04d' "$n")
    if grep -q "?id=$id " backlog.md
    then
        echo "Copying existing comment $id"
        data=$(grep "?id=$id" backlog.md | cut -d'|' -f3- | sed 's/^ *//g')
        echo "| $sno | $data" >> tmp.md
    else
        echo "Adding new comment $id"
        url="https://news.ycombinator.com/item?id=$id"
        printf "$sfmt" "$sno" "$url" >> tmp.md
        echo >> tmp.md
    fi
    n=$(( $n + 1 ))
done < ids.txt
mv tmp.md backlog.md
