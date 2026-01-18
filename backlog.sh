#!/bin/sh

grep '^| [0-9]* |' backlog*.md > comb.md

# Format strings.
h1='| #### | COMMENT ..................................... | URL ........................................... | D | I | REMARKS .................... |' > tmp.md
h2='|------|-----------------------------------------------|-------------------------------------------------|---|---|------------------------------|' >> tmp.md
#  '| 0001 | https://news.ycombinator.com/item?id=46618723 | https://jgc.org/                                | Y | Y |                              |'
                                           sfmt='| %s | %s |                                                 |   |   |                              |'

# Create tables.
SET_SIZE=500
count=$(echo $(wc -l < comb.md))
sets=$(( 1 + ($count - 1) / $SET_SIZE ))
i=1
while [ $i -le $sets ]
do
    fname="backlog$(printf '%02d' "$i").md"
    echo "Creating header for $fname"
    echo "$h1" > "$fname"
    echo "$h2" >> "$fname"
    i=$(( $i + 1 ))
done

i=1
while read -r id
do
    set=$(( 1 + ($i - 1) / $SET_SIZE ))
    fname="backlog$(printf '%02d' "$set").md"
    sno=$(printf '%04d' "$i")
    if grep -q "?id=$id " comb.md
    then
        echo "$i of $count - Copying old comment $id => $fname"
        data=$(grep "?id=$id" comb.md | cut -d'|' -f3- | sed 's/^ *//g')
        echo "| $sno | $data" >> "$fname"
    else
        echo "$i of $count - Adding new comment $id => $fname"
        url="https://news.ycombinator.com/item?id=$id"
        printf "$sfmt" "$sno" "$url" >> "$fname"
        echo >> "$fname"
    fi
    i=$(( $i + 1 ))
done < ids.txt
rm comb.md
