#/bin/bash

# bird song getter

data=`curl -s "https://ebird.org/media/catalog?date.beginMonth=1&searchField=species&date.beginYear=1900&date.endYear=2017&view=List&action=show&date.yearRange=YALL&date.endMonth=12&onlyUnrated=false&behaviors=s,c&date.monthRange=M1TO12&start=$1&count=$2&mediaType=Audio&sort=rating_rank_desc" | sed -n  "\/\/ Here we need to initially populate it:/,/}]}/p" | sed -n "/var/,/}};/p" | tail -c +38 | sed 's/.\{1\}$//' | tr "'" '"' | tr '\n' ' ' | tr '\r' ' '`

echo "{\"results\": "$data"}"