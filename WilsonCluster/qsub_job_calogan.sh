#!/bin/bash
DAT=`date +%s`
OUTFILENAME="./singularity_calogan_${DAT}.txt"
JOBNAME="calogan-${DAT}"
qsub -o $OUTFILENAME job_singularitytf_calogan.sh -N $JOBNAME
