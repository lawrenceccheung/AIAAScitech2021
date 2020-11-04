# Computing spectra and turbulence statistics for ABL cases

Two major objectives in this paper related to 
1.  What resolution is required to capture the turbulence statistics for offshore stable ABL's?
2.  How do the spectra and turbulence length-scales compare between
    - stable and neutral/unstable cases, and 
    - (if we have time) Nalu-wind vs AMR-wind?
  
 ## Resolving question 1
Question 1 can be addressed in one of two ways.  

(A) Start with baseline case, such as the [stable 5m/s](https://github.com/lawrenceccheung/AIAAScitech2021/tree/main/NaluWindRuns/stable/05ms/05ms_iter02) which was run with 10m x 10m horizontal resolution
- create multiple versions with resolutions of 5m, 2.5m, etc.
- run each of those precursors
- collect those statistics and compare between meshes.

(B) Start with baseline case, such as the [stable 5m/s](https://github.com/lawrenceccheung/AIAAScitech2021/tree/main/NaluWindRuns/stable/05ms/05ms_iter02) with 10m resolution
- Create refinement zones within the domain, similar to turbine refinement windows in ALM/ADM simulations (it may need to be larger windows to accommodate sufficient spatial sampling)
- Run this single simulation and collect statistics within each of the refinement zones
- Compare statistics between refinement zones

Method (A) is simple to set up and run, but might require more jobs.  Method (B) can be done in a single simulation, but requires more finesse in setting up the domain and statistics sampling.  Method (B) might also let us test the transition region between refinement zones and its impact on turbulence behavior.

Ideally the turbulence should be resolved to the extent needed to feed into the near-turbine mesh.

## Resolving question 2
Once the correct mesh resolution is determined from Question 1, re-run all stable wind speeds (5m/s, 10m/s, 15m/s) with correct resolution.
Compute at multiple heights (z=20m, 40m, 60m) the
- wind spectra
- integral length scale
and compare with results from neutral and unstable cases.

If time allows, should also repeat with AMR-Wind calculations.

 ## Notes
 - We may be able to use HPC resources at both Sandia and NREL
 - We need to decide on the right version of Nalu-Wind to use.
