bash
#!/bin/bash

# note the worker node's name for debugging
echo "hostname:" `/bin/hostname`
echo " "

# Properly configure the compute environment for the current release of Katydid
source /cvmfs/hep.pnnl.gov/project8/katydid/v2.17.2/setup.sh
echo " "

# confirm the environment for debugging
env
# and the files that exist before execution
ls -l
echo " "

####### This part uses any arguments you provide from the JDL and does your actual job.
####### You can put whatever you actually want here, including logic or calls to multiple
####### programs.

# Parse command arguments (they're specified in the JDL so that this script is reusable)
# and actually run katydid

CFGFILE=$1
INFILE=$2
OUTFILE1=$3
OUTFILE2=$4
Katydid -c $CFGFILE -e $INFILE --brw-file=$OUTFILE1 --rsw-file=$OUTFILE2

####### And so ends the part you should mess with, the rest of the file is more
####### debugging steps which you should leave in place.

# finally, some more debugging info: make sure you created the files you expected.
ls -l

