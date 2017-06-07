#/bin/bash
# Matt Ruffner
# June 2017

# bird JSON info getter
# parameters:
#   1st arg: result count to start from
#   2nd arg: number of results to fetch (max 100)

# pulls from ebird.org
# when searching on the site, results are stored in the page as 'var current_json_data' object

# this script 'curls' the page, changing search parameters based on script arguments, and
# then prints the stringify'd JSON, with most escaped unicode characters removed.

# filter paramets contstant over the query are: 
#   US bird audio, song + call only
#   sorted by best quality first


data=`curl -s "https://ebird.org/media/catalog?date.beginMonth=1&searchField=species&date.beginYear=1900&date.endYear=2017&regionCode=US&view=List&action=show&date.yearRange=YALL&date.endMonth=12&onlyUnrated=false&behaviors=s,c&date.monthRange=M1TO12&start=$1&count=$2&mediaType=Audio&sort=rating_rank_desc" | sed -n  "\/\/ Here we need to initially populate it:/,/}]}/p" | sed -n "/var/,/}};/p" | tail -c +38 | sed 's/.\{1\}$//' | tr "'" '"' | tr '\n' ' ' | tr '\r' ' '`

echo "{\"results\": "$data"}"