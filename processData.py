ALPHA = 0.125
BETA = 0.25

def main():
    filename_list = [("result/sampledata/sample1.dat","result/estdata/est1.dat","result/timeoutdata/timeout1.dat"),("result/sampledata/sample2.dat","result/estdata/est2.dat","result/timeoutdata/timeout2.dat"), ("result/sampledata/sample3.dat","result/estdata/est3.dat","result/timeoutdata/timeout3.dat"), ("result/sampledata/sample4.dat","result/estdata/est4.dat","result/timeoutdata/timeout4.dat")]
    for filename in filename_list:
        process_data(filename)

def process_data(filename):
    # get the file names: sampleRTT data file, EstimatedRTT data file, and TimeoutInterval data file
    samplefilename = filename[0] 
    estfilename = filename[1]
    timeoutfilename = filename[2]

    # open sampleRTT data file to read data for processing EstimatedRTT and TimeoutInterval values
    samplefile = [i.strip().split() for i in open(samplefilename).readlines()]
    estfile = open(estfilename, 'a')
    timeoutfile = open(timeoutfilename, 'a')

    firstline = samplefile[0]  # the first line in the sampleRTT data file
    firstLineFlag = False      # for checking if there is a timeout in the first line of sampleRTT data file
    try:
        estRTT = float(firstline[1])   # At first, EstimatedRTT = SampleRTT, hence devRTT = 0
    except:
        firstLineFlag = True
    devRTT = 0 
    
    for line in samplefile:
        # input current time to the EstimatedRTT and TimeoutInterval data file
        estfile.write(line[0] + " ")
        timeoutfile.write(line[0] + " ")
        try:
            sampleRTT = float(line[1])
            if firstLineFlag:   # if there is a timeout at the first line of sampleRTT data file
                estRTT = sampleRTT
                firstLineFlag = False
        except:    
            estfile.write("\n")  
            timeoutfile.write("\n")
            continue
        # compute EstimatedRTT, devRTT, and TimeoutInterval values 
        estRTT = (1 - ALPHA) * estRTT + ALPHA * sampleRTT
        devRTT = (1 - BETA ) * devRTT + BETA * abs(sampleRTT - estRTT)
        timeout = estRTT + 4 * devRTT
        estfile.write(str(estRTT) + "\n")
        timeoutfile.write(str(timeout) + "\n")

    estfile.close()
    timeoutfile.close()

if __name__ == "__main__":
    main()


