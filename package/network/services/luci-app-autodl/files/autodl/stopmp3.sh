#!/bin/sh

function stopaudio() {
	ps | grep mp3a.sh | grep -v grep | cut -d 'r' -f 1 > /tmp/tmpmp3124.tmp
	astopmp3="/tmp/tmpmp3124.tmp"
	countfiles=$(awk 'END{print NR}' $astopmp3)
	for i in $(seq 1 $countfiles)
	do
		kill $(cat $astopmp3 | head -n 1) > /dev/null 2>&1
		sed "1d" -i ${astopmp3}
	done

	runnext="/tmp/tmpmpg123.pid"
	countfiles=$(awk 'END{print NR}' $runnext)
	for i in $(seq 1 $countfiles)
	do
		kill $(cat $runnext | head -n 1) > /dev/null 2>&1
		sed "1d" -i ${runnext}
	done

	ps | grep mpg123 | grep -v grep | cut -d 'r' -f 1 > /tmp/tmpmpg123.mtmp
	runmpg123="/tmp/tmpmpg123.mtmp"
	countfiles=$(awk 'END{print NR}' $runmpg123)
	for i in $(seq 1 $countfiles)
	do
		kill $(cat $runmpg123 | head -n 1) > /dev/null 2>&1
		sed "1d" -i ${runmpg123}
	done

	ps | grep gst-play-1.0 | grep -v grep | cut -d 'r' -f 1 > /tmp/tmpmpg123.gtmp
	rungst="/tmp/tmpmpg123.gtmp"
	countfiles=$(awk 'END{print NR}' $rungst)
	for i in $(seq 1 $countfiles)
	do
		kill $(cat $rungst | head -n 1) > /dev/null 2>&1
		sed "1d" -i ${rungst}
	done

	rm /tmp/tmpmpg123.* /tmp/tmpmp3124.* myatdl.play.list myatdl.xplay.list
}

stopaudio

