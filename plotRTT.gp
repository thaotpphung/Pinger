#!/usr/local/bin/gnuplot --persist
set term postscript eps size 6,3.5 enhanced color
set output ARG4
set title ARG1
set key top left
set xlabel "time(seconds)"
set ylabel "RTT(milliseconds)"
set xrange [0:500]
plot ARG2 using 1:2 with linespoints pointtype 7 title 'SampleRTT',\
ARG3 using 1:2 with linespoints pointtype 7 title 'EstimatedRTT'