# Overview of postprocessing for ABL runs

**Contents**
- [Nalu-Wind](#nalu-wind)
- [AMR-Wind](#amr-wind)

## Nalu-Wind
**Note:** for spectra and integral lengthscale, this assumes that horizontal planes 
were written out using a `data_probes` section like this:  
```yaml
  data_probes:  
    output_format: text 
    output_frequency: 1
    search_method: stk_kdtree
    search_tolerance: 1.0e-5 
    search_expansion_factor: 2.0
    specifications:
    - name: probe_surface
      from_target_part: fluid_part  
      plane_specifications:        
        - name: sliceData/HHplane
          corner_coordinates:  [0, 0, 20]
          edge1_vector:    [1500, 0, 0]
          edge2_vector:    [0, 1500, 0]
          edge1_numPoints: 76
          edge2_numPoints: 76
          offset_vector:   [0, 0, 1]
          offset_spacings: [0, 20, 40]
      output_variables:
        - field_name: velocity
          field_size: 3
        - field_name: temperature
          field_size: 1
```

### Mean statistics
[_Fill in this section_]

### Single-point wind spectra
Processing the horizontal planes to extract single-point wind spectra
1.  Converting from planes to time series  
    Use the [pullHHplaneArgs.sh](Postprocessing/utilities/pullHHplaneArgs.sh) utility to extract 
    points out of a series of sample planes.  An example of its use is in the 
    [extractlog_plane0.sh](NaluWindRuns/stable/05ms/05ms_iter02/extractlog_plane0.sh) script
```bash
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
```

2.  Use the [`windspectra.py`](Postprocessing/utilities/windspectra.py) library to compute spectra.
    The `windspectra.py` library takes the time-series, Fourier tranforms them and averages them. 
    An example of its usage is in [Spectra_Stable_05ms.ipynb](NaluWindRuns/stable/05ms/05ms_iter02/Spectra_Stable_05ms.ipynb).
    Note the inputs in the cell below.
```python
# Define data locations and variables
datadir = 'rundir/spectra/HHplane_plane0/'
planeprefix = 'HHplane_'
planenum = 0
jvector  = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75] 
ivector  = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75] 

# Averaging bins
# Multiple averaging bins possible.   
# Default empty list ([]) is to use the entire time-series as one bin.
# Example for two bins with 50% overlap is avgins=[[15000, 16000],[15500, 16500]]
avgbins = [] 

# Friction velocity.  Eventually this should be pulled from the ABL stats file
utau     = 0.1492
```
    The `planenum`, `ivector`, and `jvector` should correspond to points used in step #1.  You can set `avgbins` to 
    separate the time-series into multiple bins, and `utau` is used in non-dimensionalization of the plots.

### Integral length scale


## AMR-Wind
[_Fill in this section_]
