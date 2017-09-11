#!/bin/sh

wget -qO trackers.html "http://www.torrenttrackerlist.com/torrent-tracker-list/"

#grep -oP '(?<=<pre class="prettyprint"> ).*?(?= </pre>)' trackers.html | grep -ve '^$' > list.txt

sed -n "/<pre class=\"prettyprint\">/,/<\/pre>/p" trackers.html |  sed -e 's/<pre class=\"prettyprint\">//g ; s/<\/pre>//g' | grep -ve '^$\|^[[:space:]]*$' > /mnt/HD/HD_a2/list.txt

rm trackers.html




