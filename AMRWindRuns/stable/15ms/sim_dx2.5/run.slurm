#!/bin/bash

#SBATCH --job-name=stable15
#SBATCH --nodes=108
#SBATCH --time=36:00:00
#SBATCH --output=out.%x_%j
#SBATCH --account=hfm

source /projects/hfm/shreyas/exawind/scripts/exawind-env-intel.sh

ranks_per_node=36
mpi_ranks=$(expr $SLURM_JOB_NUM_NODES \* $ranks_per_node)
export OMP_NUM_THREADS=1  # Max hardware threads = 4
export OMP_PLACES=threads
export OMP_PROC_BIND=spread


echo "Job name       = $SLURM_JOB_NAME"
echo "Num. nodes     = $SLURM_JOB_NUM_NODES"
echo "Num. MPI Ranks = $mpi_ranks"
echo "Num. threads   = $OMP_NUM_THREADS"
echo "Working dir    = $PWD"


srun -n 3888 -c 1 --cpu_bind=cores ../../../../../amr-wind/build/amr_wind ../abl.inp time.stop_time=15000.0 ABL.stats_output_frequency=16 sampling.output_frequency=1600 > log0
srun -n 3888 -c 1 --cpu_bind=cores ../../../../../amr-wind/build/amr_wind ../abl.inp time.stop_time=20000.0 io.restart_file="chk240000" ABL.stats_output_frequency=8  sampling.output_frequency=8    > log1

