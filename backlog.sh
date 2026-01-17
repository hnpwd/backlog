#!/bin/sh

touch backlog.md
echo '| COMMENT                                       | URL | D | I | REM |' > tmp.md
echo '|-----------------------------------------------|-----|---|---|-----|' >> tmp.md
while read -r id
do
    if grep -q "?id=$id " backlog.md
    then
        echo "Copying existing comment $id"
        grep "?id=$id" backlog.md >> tmp.md
    else
        echo "Adding new comment $id"
        url="https://news.ycombinator.com/item?id=$id"
        echo "| $url |     |   |   |     |" >> tmp.md
    fi
done < ids.txt
mv tmp.md backlog.md
