#!/bin/bash
#AUTHOR: Rens Holmer
#Run maker with MPI on assembly server

usage() { printf "\n Usage $0:\n$1 input fasta\n$2 number of threads\n\n" 1>&2; exit 1;}

if [ $# != 2 ]
        then
        usage
fi

if  [ ! -f maker_opts.ctl ] || \
        [ ! -f maker_exe.ctl ] || \
        [ ! -f maker_bopts.ctl ]
        then
        printf "\n maker CTL files missing!\n\n" 1>&2; exit 1;
fi


export ZOE="/mnt/nexenta/holme003/progs_nobackup/maker/exe/snap/Zoe"
export AUGUSTUS_CONFIG_PATH="/mnt/nexenta/holme003/progs_nobackup/maker/exe/augustus/config"
export LD_PRELOAD=/usr/lib/openmpi/lib/libmpi.so

mpiexec -mca btl ^openib -n $2 /mnt/nexenta/holme003/progs_nobackup/maker/bin/maker -g $1 -nodatastore -c 1 -quiet 
