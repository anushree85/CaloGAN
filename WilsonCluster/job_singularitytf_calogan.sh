#!/bin/bash
#PBS -S /bin/bash
#PBS -N lasagne-conv-mnv
#PBS -j oe
#PBS -o ./lasagne_conv_out_job.txt
# not 1 #PBS -l nodes=gpu1:gpu:ppn=2,walltime=24:00:00
# not 2 #PBS -l nodes=gpu2:gpu:ppn=2,walltime=24:00:00
# not 3 #PBS -l nodes=gpu3:gpu,walltime=24:00:00
#PBS -l nodes=1:gpu,walltime=24:00:00
# not short #PBS -l nodes=1:gpu,walltime=6:00:00
#PBS -A minervaG
#PBS -q gpu
#restore to turn off email (doesn't work) #PBS -m n

NEPOCHS=12
NEPOCHS=1

DATET=`date +%s`

IMGDIR="/data/perdue/singularity/simone"
SINGIMG="ubuntu16-cuda-ml.img"

PARTICLE_LISTS_DIR="/data/perdue/CrystalCaloGAN/lists"
WEIGHTS_DIR="/data/perdue/CrystalCaloGAN/weights_${DATET}"
if [[ -d $WEIGHTS_DIR ]]; then
  echo "Weights directory exists! Refusing to run..."
  exit 1
fi
mkdir $WEIGHTS_DIR

# print identifying info for this job
echo "Job ${PBS_JOBNAME} submitted from ${PBS_O_HOST} started "`date`" jobid ${PBS_JOBID}"

cat ${PBS_NODEFILE}

cd ${PBS_O_WORKDIR}
echo "PBS_O_WORKDIR is `pwd`"
cd ..
GIT_VERSION=`git describe --abbrev=12 --dirty --always`
echo "Git repo version is $GIT_VERSION"
DIRTY=`echo $GIT_VERSION | perl -ne 'print if /dirty/'`
if [[ $DIRTY != "" ]]; then
  echo "Git repo contains uncomitted changes! Please commit your changes"
  echo "before submitting a job. If you feel your changes are experimental,"
  echo "just use a feature branch."
  echo ""
  echo "Changed files:"
  git diff --name-only
  echo ""
  # exit 0
fi


cat << EOF
singularity exec $IMGDIR/$SINGIMG python -m models.train \
  $PARTICLE_LISTS_DIR/particles.yaml \
  --nb-epochs $NEPOCHS \
  --d-pfx $WEIGHTS_DIR/params_discriminator_epoch_ \
  --g-pfx $WEIGHTS_DIR/params_generator_epoch_
EOF
singularity exec $IMGDIR/$SINGIMG python -m models.train \
  $PARTICLE_LISTS_DIR/particles.yaml \
  --nb-epochs $NEPOCHS \
  --d-pfx $WEIGHTS_DIR/params_discriminator_epoch_ \
  --g-pfx $WEIGHTS_DIR/params_generator_epoch_


echo "Job ${PBS_JOBNAME} submitted from ${PBS_O_HOST} finished "`date`" jobid ${PBS_JOBID}"
exit 0
