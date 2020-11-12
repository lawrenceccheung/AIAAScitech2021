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
1.  Use the [NaluWindAvg.py](Postprocessing/utilities/NaluWindAvg.py)
    script to generate mean profiles and mean ABL statistics.  It uses
    the [plotABLstats.py](Postprocessing/utilities/NaluWindAvg.py)
    library to process the `abl_statistics.nc` output.
	
	

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

### Turbulent integral length scale
Calculating the two point Rij correlation and turbulent integral length scale is done 
through the [correlate.py](Postprocessing/utilities/correlate.py) script.
An example of its usage is in the [ABLLengthscale_Stable_05](NaluWindRuns/stable/05ms/05ms_iter02/ABLLengthscale_Stable_05.ipynb) 
jupyter notebook.

1.  Set up the paths to data and which iterations to use for calculating correlations
```python
# Set the parameters
prefix='stable05'
basedir='rundir/sliceData'
filebase='HHplane_%07i_0.dat'

iters=np.arange(30001,31001, 5) 
loadfromplanes = True   # If True, calculate the average from individual plane files.  If False, load from avgsavefile
plotprobept    = True   # If True, plot the probe locations
iplane = 0
ij   = [0,0]

avgsavefile     = prefix+'_avgplane_%i_%i_%i.dat'%(iters[0],iters[-1],len(iters))
Rijsavefile     = prefix+'_avgRij_%i_%i_%i_iplane_%i.dat'%(iters[0],iters[-1],len(iters),iplane)
```

2. Compute the mean across all sample plans
```python
# Load the average (compute if needed)
avgdat, headers       = corr.loadavg(filelist, loadfromplanes, avgsavefile, verbose=True)
ws, winddir           = corr.getavgwind(avgdat, headers, iplane)
```

3.  Compute the probe sample points for correlation computations using `corr.makeprobeline()`
```python
# Create the probe list for LONGITUDINAL
# Set parameters
winddir= 225
if (winddir>270): s=-1
else:             s=+1
startx = np.arange(0,61,5)
starty = np.arange(0,61,5)[::s]
probelength = 750 # Probe length should be a few hundred meters
startp = []
yoffset=0
[[startp.append([x,y+yoffset*iy,iplane]) for x in startx] for iy, y in enumerate(starty)]

plistLONG = corr.makeprobeline(startp, winddir, probelength, avgdat)
```

4.  Compute the Rij correlations
```python
allf, allRij = corr.makeRij(ij, plist, filelist, loadfromplanes, avgsavefile, verbose=True)
```
Averaged Rij results should look like this:  
![RijAveraging](https://user-images.githubusercontent.com/15526007/98852222-34dc6a80-240c-11eb-89ec-b8ec13306010.png)

Across multiple conditions it should look like  
![Rij](https://user-images.githubusercontent.com/15526007/98851539-4113f800-240b-11eb-92ae-58f1770b6822.png)

5.  Integrate Rij to get the integral length scale
```python
# Calculate lengthscale
lengthscale = corr.calclengthscale(allf[0], avgRijLong)
print('LONG lengthscale = %f'%lengthscale)
```
## AMR-Wind
[_Fill in this section_]
