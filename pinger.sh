#!/bin/sh
filenameList=("stackoverflow.com result/sampledata/sample1.dat result/estdata/est1.dat result/timeoutdata/timeout1.dat result/graph/2.1.ps result/graph/3.1.ps" "www.ox.ac.uk result/sampledata/sample2.dat result/estdata/est2.dat result/timeoutdata/timeout2.dat result/graph/2.2.ps result/graph/3.2.ps" "www.nus.edu.sg result/sampledata/sample3.dat result/estdata/est3.dat result/timeoutdata/timeout3.dat result/graph/2.3.ps result/graph/3.3.ps" "www.su.se result/sampledata/sample4.dat result/estdata/est4.dat result/timeoutdata/timeout4.dat result/graph/2.4.ps result/graph/3.4.ps")

# set up directories to save result files
rm -rf result  #remove if the file exists, else do nothing
mkdir result
cd result
mkdir sampledata
mkdir estdata
mkdir timeoutdata
mkdir graph
cd ..

# get sampleRTT
for i in "${filenameList[@]}"; do   
    set -- $i
    bash recordPingVal.sh $1 $2
done

# compute EstimatedRTT and TimeoutInterval values and generate data files for corresponding graphs.
python3 processData.py

# plotting data using GNUplot
# plot SampleRTT and EstimatedRTT for 4 IP addresses
for i in "${filenameList[@]}"; do   
    set -- $i
    gnuplot -c plotRTT.gp $1 $2 $3 $5
done

# plot TimeoutInterval for 4 IP addresses
for i in "${filenameList[@]}"; do   
    set -- $i
    gnuplot -c plotTimeout.gp $1 $4 $6
done


