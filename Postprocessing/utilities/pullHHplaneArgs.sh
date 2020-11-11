#!/bin/sh

disphelp() {
    echo "$0 PLANEFILES"
    echo 
    echo "OPTIONS"
    echo " -a,--append"
    echo " -p,--planenum"
    echo " -i,--iindex"
    echo " -j,--jindex"
    echo " -h,--help        Display help"
    exit 1
}

# Set the defaults
planenum=0
jindex="0"
iindex="0"
append=false
outdir=HHplane/

while (( "$#" )); do
    case "$1" in
	-a|--append)
	    append=true
	    shift 1
	    ;;
	-o|--outdir)
	    outdir=$2
	    shift 2
	    ;;
	-p|--planenum)
	    planenum=$2
	    shift 2
	    ;;
	-i|--iindex)
	    iindex="$2"
	    shift 2
	    ;;
	-j|--jindex)
	    jindex="$2"
	    shift 2
	    ;;
	-h|--help)
	    disphelp
	    break
	    ;;
	--) # end argument parsing
	    shift
	    break
	    ;;
	-*|--*=) # unsupported flags
	    echo "Error: Unsupported flag $1" >&2
	    exit 1
	    ;;
	*) # preserve positional arguments
	    PARAMS="$PARAMS $1"
	    shift
	    ;;
    esac
done

# set positional arguments in their proper place
eval set -- "$PARAMS"

# All of the other arguments
planefiles="$@"


echo "planenum = $planenum"
echo "jindex   = $jindex"
echo "iindex   = $iindex"
echo "outdir   = $outdir"
#echo "planefiles = $planefiles"
#exit 1

#planedir=../HHplane/
#planefiles=`ls $planedir/HHplane_003[01]???_0.dat $planedir/HHplane_0032[0-7]??_0.dat`
#planefiles=`ls $planedir/HHplane_003[012]???_0.dat`
#planefiles=`ls $planedir/HHplane_0033???_0.dat`
#EXTRACTSCRIPT=~/local/bin/extractpointfast.sh
SCRIPTDIR=`dirname "$0"`
EXTRACTSCRIPT=${SCRIPTDIR}/extractpointfast.sh

for j in $jindex; do
    for i in $iindex; do
	echo $planenum $j $i 
	if [ "$append" = true ]; then
	    $EXTRACTSCRIPT -n  $planenum $j $i $planefiles >> ${outdir}/HHplane_${planenum}_${j}_${i}.dat
	else
	    $EXTRACTSCRIPT  $planenum $j $i $planefiles > ${outdir}/HHplane_${planenum}_${j}_${i}.dat
	fi
    done
done
