# loop for 100 times, from 0 to 495 with a distance of 5
for i in `seq 0 5 495`
do
    # input the time
    echo -n $i\ >> $2
    # ping and record the result to the sample.dat file
    ping -c 1 $1  | sed -n '2 p' | awk '{print $7}' >> $2
    # fix the format of sample.dat for file processing
    sed -i.bak 's/time=//g' $2   # for MacOS format
    # sleep 5 seconds before ping again        
    sleep 5
done