## %%capture
# Important header information
naluhelperdir = '/ascldap/users/lcheung/local/Git/naluhelperscripts/'
# Import libraries
import sys
import numpy as np
import matplotlib.pyplot as plt
sys.path.insert(1, naluhelperdir)
import plotABLstats
import yaml as yaml
#from IPython.display import Image
from matplotlib.lines import Line2D
import matplotlib.image as mpimg
## %matplotlib inline
# Define a useful function for pull stuff out of dicts
getparam = lambda keylabel, pdict, default: pdict[keylabel] if keylabel in pdict else default

# Target TI conditions
target_unstable = [[5,     10,    15],             # WS
                   [0.080, 0.075, 0.09],           # TI levels
                   [0.0,   0.0,   0.0],]           # Shear levels
target_neutral  = [[5,     10,    15],             # WS
                   [0.055, 0.055, 0.065]]          # TI levels
target_stable   = [[5,     10,    15 ],
                   [0.045, 0.05,  0.06]]

# Locations of all of the runs
baserundir = '/ascldap/users/lcheung/nscratch/Torque2020/Runs/'
NumReqCols = 4   # Number of required columns in the table

# Index of all runs here
runlist=[
    # Name,          Location,                    averaging times,  yaml file, extra dict
    # -- Stable runs --
    #['stable  5m/s', 'stable/05ms/05ms_iter01',     [15000, 20000],  'abl_stable05ms_iter01_run1.yaml', {'ablfile':'abl_statistics.nc','color':'b', 'lw':2, 'pngimage':'HHplane_0014000_0_plane0.png'}],
    #['stable 10m/s', '/stable/10ms/10ms_iter01',        [15000, 20000],  'abl_stable10ms_iter01_run1.yaml', {'ablfile':'abl_statistics.nc','color':'b', 'lw':2, 'pngimage':'HHplane_0014000_0_plane0.png'}],
    #['stable 15m/s', 'stable/15ms/15ms_iter01',     [15000, 20000],  'abl_stable15ms_iter01_run1.yaml', {'ablfile':'abl_statistics.nc','color':'b', 'lw':2, 'pngimage':'HHplane_0014000_0_plane0.png'}],
    #['stable 15m/s', 'stable/15ms/15ms_iter02',     [15000, 20000],  'abl_stable15ms_iter02_run1.yaml', {'ablfile':'abl_statistics.nc','color':'b', 'lw':2, 'pngimage':'HHplane_0014000_0_plane0.png'}],
    #['stable  5m/s', 'stable/05ms/05ms_iter02',     [15000, 20000],  'abl_stable05ms_iter02_run1.yaml', {'ablfile':'abl_statistics.nc','color':'b', 'lw':2, 'pngimage':'HHplane_0014000_0_plane0.png'}],
    ['stable  5m/s', 'stable/05ms/05ms_iter02',     [10000, 15000],  'abl_stable05ms_iter02_run1.yaml', {'ablfile':'abl_statistics.nc','color':'b', 'lw':2, 'savedir':'../../NaluWindRuns/stable/05ms/05ms_iter02/10k_15k'}],
    
   # # -- Neutral runs --
   # ['neutral 5m/s',  'neutral/05ms/05ms_iter07',  [15000, 20000], 'abl_neut05ms_iter07_run1.yaml', {'ablfile':'abl_statistics.nc', 'color':'g', 'lstyle':'-', 'lw':2.5, 'pngimage':'HHplane_0030000_0_plane0.png'}],
   # ['neutral 10m/s', 'neutral/10ms/10ms_iter03',  [15000, 20000], 'abl_neut10ms_iter03_run1.yaml', {'color':'g', 'lstyle':'--', 'lw':2.5, 'pngimage':'HHplane_0030000_0_plane0.png'}],
   # ['neutral 15m/s', 'neutral/15ms/15ms_iter03',  [15000, 20000], 'abl_neut15ms_iter03_run1.yaml', {'color':'g', 'lstyle':'-.', 'lw':2.5, 'pngimage':'HHplane_0030000_0_plane0.png'}],

   # # -- Unstable runs --
   # ['unstable 5m/s', 'unstable/05ms/05ms_iter01',   [15000, 20000],  'abl_unstable05ms_iter01_run1.yaml', {'color':'r', 'lw':2, 'pngimage':'HHplane_0016000_0_plane0.png'}],
   # ['unstable 10m/s','unstable/10ms/10ms_iter01',   [15000, 25000],  'abl_unstable10ms_iter01_run1.yaml', {'color':'r', 'lw':2,'lstyle':'--', 'pngimage':'HHplane_0010000_0_plane0.png'}],
   # ['unstable 15m/s','unstable/15ms/15ms_iter01',   [15000, 20000],   'abl_unstable15ms_iter01_run2.yaml', {'color':'r', 'lw':2,'lstyle':'-.'}],
]

# Hub-height locations
plotheights=[20]

# Pull the data from disk
alldata=[]
allVdata=[]
allTIdata=[]
allTdata=[]
allVeerdata=[]
allAlphadata=[]
allutau=[]
allREstresses=[]
alltfluxdata=[]

for run in runlist:
    rundict       = run[NumReqCols] if (len(run)>NumReqCols) else {}
    statsfile     = rundict['ablfile'] if 'ablfile' in rundict else 'abl_statistics.nc'
    rundir        = baserundir+'/'+run[1]
    avgtimes      = run[2]
    data          = plotABLstats.ABLStatsFileClass(stats_file=rundir+'/'+statsfile);
    runresults    = plotABLstats.reportABLstats(data, heights=plotheights, tlims=avgtimes);
    alldata.append(runresults[0])
    utau          = plotABLstats.avgutau(data, heights=plotheights, tlims=avgtimes);
    allutau.append(utau)
    
    tfluxprof, tfluxheader = plotABLstats.plottfluxprofile(data, None, tlims=avgtimes, exportdata=True)
    alltfluxdata.append(tfluxprof)

    # Profile information
    Vprof,  Vheader    = plotABLstats.plotvelocityprofile(data, None, tlims=avgtimes, exportdata=True)
    TIprof, TIheader   = plotABLstats.plotTIprofile(data, None, tlims=avgtimes, exportdata=True)
    Tprof,  Theader    = plotABLstats.plottemperatureprofile(data, None, tlims=avgtimes, exportdata=True)
    Veerprof, Veerheader = plotABLstats.plotveerprofile(data, None, tlims=avgtimes, exportdata=True)
    Alphaprof,Alphaheader = plotABLstats.plotShearAlpha(data, None, tlims=avgtimes, exportdata=True)
    # Extract TKE and Reynolds stresses
    REstresses, REheader = plotABLstats.plottkeprofile(data, None, tlims=avgtimes, exportdata=True)
    
    allVdata.append(Vprof)
    allTIdata.append(TIprof)
    allTdata.append(Tprof)
    allVeerdata.append(Veerprof)
    allAlphadata.append(Alphaprof)
    allREstresses.append(REstresses)
allrundata=np.array(alldata)

# Print a pretty table of the hub-height results
print("%-22s %8s %8s %10s %12s %15s %12s"%("Name", "WS [m/s]","TI [-]","Alpha [-]","WDir [deg]","Obukhov L[m]","Utau [m/s]"))
print("%-22s %8s %8s %10s %12s %15s %12s"%("====", "========","======","=========","==========","============","=========="))
for ir, row in enumerate(runlist):
    name = row[0]
    data = alldata[ir]
    print("%-22s %8.2f %8.4f %10.4f %12.2f %15.3e %12.4f"%(name, data[0], data[1], data[2], data[3],data[4],allutau[ir]))

# Save the profile data to text files
for irun, row in enumerate(runlist):
    rundir        = baserundir+'/'+row[1]
    rundict       = row[4]
    savedir       = getparam('savedir', rundict, rundir)
    print("Saving to "+savedir)
    # Save velocity
    np.savetxt(savedir+'/NaluWind_temperaturefluxes.dat', alltfluxdata[irun], header=tfluxheader.replace(',',''), comments='')
    np.savetxt(savedir+'/NaluWind_velocity.dat',         allVdata[irun], header=Vheader)
    np.savetxt(savedir+'/NaluWind_temperature.dat',      allTdata[irun], header=Theader)
    np.savetxt(savedir+'/NaluWind_TI.dat',               allTIdata[irun], header=TIheader)
    np.savetxt(savedir+'/NaluWind_Veer.dat',             allVeerdata[irun], header=Veerheader)
    np.savetxt(savedir+'/NaluWind_Alpha.dat',             allAlphadata[irun], header=Alphaheader)
    np.savetxt(savedir+'/NaluWind_reynoldsstresses.dat', allREstresses[irun], header=REheader)

# Save the integrated data to yaml file
if True:
    for irun, row in enumerate(runlist):
        rundir        = baserundir+'/'+row[1]
        rundict       = row[4]
        savedir       = getparam('savedir', rundict, rundir)
        print("Saving to "+savedir)
        data          = alldata[irun]
        avgtimes      = row[2]
        # Write the YAML file with integrated quantities
        savedict={'WS':float(data[0]), 
                  'TI':float(data[1]),
                  'alpha':float(data[2]), 
                  'WDir':float(data[3]),
                  'L':float(data[4]),
                  'utau':float(allutau[irun]),
        }

        f=open(savedir+'/istats.yaml','w')
        f.write('# Averaged quantities from %f to %f\n'%(avgtimes[0], avgtimes[1]))
        f.write(yaml.dump(savedict, default_flow_style=False))
        f.close()
