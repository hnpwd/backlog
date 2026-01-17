update: fetch backlog

backlog:
	sh backlog.sh

fetch:
	curl -sS 'https://hacker-news.firebaseio.com/v0/item/46618714.json' | jq '.kids[]' | sort -n > ids.txt
