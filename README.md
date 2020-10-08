# AIAA Scitech 2021
**Computation and comparison of the stable Northeastern US marine boundary layer**

## Getting started
Take a look at some of the previously published items
### Previous papers/publications
- Read the paper by [Archer et al](literature/Archer_JGR_2016JD024896.pdf), which describes the Cape Wind met mast measurements
- Look at the [Torque 2020 paper](literature/Cheung_2020_J_Phys_Conf_Ser_1618_062038.pdf) which describes the unstable and neutral results
- Look at the [AIAA scitech abstract](literature/Scitech2021_Abstract_SAND2020-5758A.pdf) to see what we promised to do

### Previous runs
- [Outline of cases](PreliminaryThoughts.ipynb): A jupyter notebook summarizing the targeted conditions for stable, unstable, and neutral (based on Archer et al)
- [NaluWindRuns neutral](NaluWindRuns/neutral): Directory of neutral Nalu-Wind input files for neutral 5m/s, 10m/s and 15 m/s
- [NaluWindRuns unstable](NaluWindRuns/unstable): Directory of unstable Nalu-Wind input files for neutral 5m/s, 10m/s and 15 m/s

### Postprocessing
- [Mean ABL stats and profiles](Postprocessing/ABLStats/All_Good_ABLRuns.ipynb): Summary of mean ABL statistics on simulations so far
- Spectra computations: Jupyter notebooks for     
   o [Neutral  5m/s](Postprocessing/ABLSpectra/Spectra_Neutral_05ms.ipynb)  
   o [Neutral 10m/s](Postprocessing/ABLSpectra/Spectra_Neutral_10ms.ipynb)  
   o [Neutral 15m/s](Postprocessing/ABLSpectra/Spectra_Neutral_15ms.ipynb)  
   o [Unstable  5m/s]](Postprocessing/ABLSpectra/Spectra_Unstable_05ms.ipynb)  
   o [Unstable 10m/s]](Postprocessing/ABLSpectra/Spectra_Unstable_10ms.ipynb)  
   o [Unstable 15m/s]](Postprocessing/ABLSpectra/Spectra_Unstable_15ms.ipynb)  

## Work under way
- [NaluWindRuns stable](NaluWindRuns/stable): Runs completed for stable 5m/s, 10m/s and 15m/s  
   o Each run for 20,000 secs on 3km x 3km x 1km domain  
   o Averaged mean profiles gathered  

## To do for scitech
- [ ] Run matching AMR-Wind cases for stable ABL's
