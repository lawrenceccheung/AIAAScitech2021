#!/bin/sh

NCFILE=post_processing/sampling60000.nc

#python extractTimeSeries.py $NCFILE -x `seq 0 100 900` -y `seq   0 100 200` -z 20 -o spectra/HHplane_plane0/HHplane_%05.0f_%05.0f_%05.0f.dat  &
#python extractTimeSeries.py $NCFILE -x `seq 0 100 900` -y `seq 300 100 500` -z 20 -o spectra/HHplane_plane0/HHplane_%05.0f_%05.0f_%05.0f.dat  &
#python extractTimeSeries.py $NCFILE -x `seq 0 100 900` -y `seq 600 100 900` -z 20 -o spectra/HHplane_plane0/HHplane_%05.0f_%05.0f_%05.0f.dat  &

python extractTimeSeries.py $NCFILE -x `seq 0 100 900` -y `seq   0 100 200` -z 40 -o spectra/HHplane_plane1/HHplane_%05.0f_%05.0f_%05.0f.dat  &
python extractTimeSeries.py $NCFILE -x `seq 0 100 900` -y `seq 300 100 500` -z 40 -o spectra/HHplane_plane1/HHplane_%05.0f_%05.0f_%05.0f.dat  &
python extractTimeSeries.py $NCFILE -x `seq 0 100 900` -y `seq 600 100 900` -z 40 -o spectra/HHplane_plane1/HHplane_%05.0f_%05.0f_%05.0f.dat  &

