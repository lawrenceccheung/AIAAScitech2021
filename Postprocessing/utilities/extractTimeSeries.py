import sys
import matplotlib.pyplot as plt
import numpy as np
from netCDF4 import Dataset
import os.path
import argparse

def findMatchingPt(ptlist, p, eps):
    for ipt, xpt in enumerate(ptlist):
        if (np.linalg.norm(np.array(xpt)-np.array(p)))<eps: return ipt
    # Error out
    raise Exception("error in findMatchingPt") 
        
def writeTimeSeries(ncdat, xvec, yvec, zvec, savestring, verbose=True):
    """
    Average the spectra over multiple x, y, z locations
    """
    Nt     = ncdat.dimensions['num_time_steps'].size
    Npts   = ncdat['p_h'].dimensions['num_points'].size
    allpts = ncdat['p_h'].variables['coordinates']
    
    t      = ncdat['time'][:]
    allvx  = ncdat['p_h'].variables['velocityx']
    allvy  = ncdat['p_h'].variables['velocityy']
    allvz  = ncdat['p_h'].variables['velocityz']
    Navg   = 0
    zerocol = np.zeros(len(t))
    all_ulongavgs = []
    for x in xvec:
        for y in yvec:
            for z in zvec:
                xyzpt = np.array([x,y,z])
                ipt   = findMatchingPt(allpts, xyzpt, 1.0E-6)
                #print(allpts[ipt, :])
                u = allvx[:,ipt]
                v = allvy[:,ipt]
                w = allvz[:,ipt]
                xcol = x*np.ones(len(t))
                ycol = y*np.ones(len(t))
                zcol = z*np.ones(len(t))
                savedat = np.vstack((t, zerocol, zerocol, zerocol, xcol, ycol, zcol, u, v, w))
                fname=savestring%(x,y,z)
                np.savetxt(fname, savedat.transpose())
                if verbose: print("saved "+fname)


# ========================================================================
#
# Main
#
# ========================================================================
if __name__ == "__main__":

    helpstring="""
Extract time-series from AMR-Wind netcdf file

Example:
    
    python extractTimeSeries.py post_processing/sampling60000.nc -x 0 100 200 -y 0 100 200 -z 20 -o spectra/point_%05.0f_%05.0f_%05.0f.dat
    """

    # Parse arguments
    parser = argparse.ArgumentParser(description=helpstring, 
                                     formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument(
        "ncfile",
        help="netcdf file",
        type=str,
    )
    parser.add_argument(
        "-o",
        "--outfile",
        help="output file format",
        default='point_%5.0f_%5.0f_%5.0f.dat',
        type=str,
    )

    parser.add_argument(
        "-x",
        nargs='+',
        help="x points to extract",
        dest='xpts',
        required=True,
    )

    parser.add_argument(
        "-y",
        nargs='+',
        help="y points to extract",
        dest='ypts',
        required=True,
    )

    parser.add_argument(
        "-z",
        nargs='+',
        help="z points to extract",
        dest='zpts',
        required=True,
    )

    # Load the options
    args = parser.parse_args()
    filename  = args.ncfile
    savefile  = args.outfile
    xpts      = [float(x) for x in args.xpts]
    ypts      = [float(y) for y in args.ypts]
    zpts      = [float(z) for z in args.zpts]
    print("netcdf file    = "+filename)
    print("output format  = "+savefile)
    print("xpts           = "+repr(xpts))
    print("ypts           = "+repr(ypts))    
    print("zpts           = "+repr(zpts))

    ncdata   = Dataset(filename, 'r')
    writeTimeSeries(ncdata, xpts, ypts, zpts, savefile, verbose=True)
