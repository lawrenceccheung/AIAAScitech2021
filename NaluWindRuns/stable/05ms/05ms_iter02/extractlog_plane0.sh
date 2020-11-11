#!/bin/sh

SCRIPTDIR=../../../../Postprocessing/utilities/
PULLSCRIPT=$SCRIPTDIR/pullHHplaneArgs.sh
OUTPUTDIR=./rundir/spectra/HHplane_plane0/
DATADIR=./rundir/sliceData/

$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "0"  $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "5"  $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "10" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "15" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "20" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "25" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "30" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "35" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "40" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "45" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "50" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "55" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "60" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "65" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "70" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
$SCRIPTDIR/pullHHplaneArgs.sh -p 0 -i "`seq 0 5 75`" -j "75" $DATADIR/HHplane_003[0-9]???_0.dat -o $OUTPUTDIR/
