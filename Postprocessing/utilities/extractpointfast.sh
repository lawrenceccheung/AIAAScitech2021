#!/bin/sh

disphelp() {
    echo "$0 PLANENUM INDEXJ INDEXI PLANEFILES(s)"
    echo 
    echo "OPTIONS"
    echo " -n,--noheader    Don't add header to the top"
    echo " -h,--help        Display help"
    exit 1
}

addheader=true
while (( "$#" )); do
    case "$1" in
	-n|--noheader)
	    addheader=false
	    shift 1
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

if [ "$#" -lt 4 ]; then
    echo "Need at least 4 arguments"
    disphelp
fi

planenum=$1
shift
indexj=$1
shift 
indexi=$1
shift

if [ "$addheader" = true ]; then
    header=`zgrep Plane_Number $1`
    echo "$header"|sed  "s/#/#Time/g"
fi

# Get the line number of match on first file
linenum=`zgrep -n -m1 -E "^\s+$planenum\s+$indexj\s+$indexi\s+" $1|awk '{print $1}' | sed 's/://g' `

for plane in "$@"; do
    #time=`zgrep -m1 "Time" $plane | awk '{print $2}'`
    #data=`zgrep -m1 -E "^\s+$planenum\s+$indexj\s+$indexi\s+" $plane`
    #echo "LINENUM = $linenum"

    time=`head -n1  $plane | awk '{print $2}'`
    data=`sed "${linenum}q;d" $plane`
    echo "$time" "$data"
done
