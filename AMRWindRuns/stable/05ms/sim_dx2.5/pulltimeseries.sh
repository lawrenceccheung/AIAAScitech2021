#!/bin/sh

#NCFILE=post_processing/sampling60000.nc
NCFILE=post_processing_dx2.5/sampling60000.nc
OUTFILE=spectra/HHplane_plane0/HHplane_%05.0f_%05.0f_%05.0f.dat

#python extractTimeSeries.py $NCFILE -x `seq 0 50 550` -y `seq   0  50 150` -z 0\
# -i -g 'p_f' -o $OUTFILE  &
#python extractTimeSeries.py $NCFILE -x `seq 0 50 550` -y `seq 200  50 350` -z 0\
# -i -g 'p_f' -o $OUTFILE  &
#python extractTimeSeries.py $NCFILE -x `seq 0 50 550` -y `seq 400  50 550` -z 0\
# -i -g 'p_f' -o $OUTFILE  &

python extractTimeSeries.py $NCFILE -x `seq 0 50 550` -y 450 550 -z 0\
 -i -g 'p_f' -o $OUTFILE  

#python extractTimeSeries.py $NCFILE -x `seq 0 100 900` -y `seq   0 100 200` -z 40 -o spectra/HHplane_plane1/HHplane_%05.0f_%05.0f_%05.0f.dat  &
#python extractTimeSeries.py $NCFILE -x `seq 0 100 900` -y `seq 300 100 500` -z 40 -o spectra/HHplane_plane1/HHplane_%05.0f_%05.0f_%05.0f.dat  &
#python extractTimeSeries.py $NCFILE -x `seq 0 100 900` -y `seq 600 100 900` -z 40 -o spectra/HHplane_plane1/HHplane_%05.0f_%05.0f_%05.0f.dat  &

