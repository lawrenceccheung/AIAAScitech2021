#!/bin/sh

NCFILE=post_processing_dx2.5/sampling60000.nc
OUTFILE=spectra/HHplane_plane1/HHplane_%05.0f_%05.0f_%05.0f.dat

python extractTimeSeries.py $NCFILE -x `seq 0 50 550` -y `seq   0  50 150` -z 1 -i -g 'p_f' -o $OUTFILE  &
python extractTimeSeries.py $NCFILE -x `seq 0 50 550` -y `seq 200  50 350` -z 1 -i -g 'p_f' -o $OUTFILE  &
python extractTimeSeries.py $NCFILE -x `seq 0 50 550` -y `seq 400  50 550` -z 1 -i -g 'p_f' -o $OUTFILE  &
