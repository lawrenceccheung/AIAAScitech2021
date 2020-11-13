# Grid sizes for simulations

Nalu-Wind branch: 
- Use Matt Churchfield's branch: https://github.com/mchurchf/nalu-wind/tree/f/ABLWallBCUpgrade  
- commit: a134dd0 
Sample planes at least 1 per second.

Stable 5m/s  [Alan SNL]
-------------------
dx = 2.5 m  Lx=750m  
dy = 2.5 m  Ly=750m  
dz = 2.5 m  Lz=1000m  
dt = 0.25 sec  
T  = 20,000s  

Stable 10m/s [Ganesh Eagle]  
-------------------
dx = 2.5 m  Lx=750m  
dy = 2.5 m  Ly=750m  
dz = 2.5 m  Lz=1000m  
dt = 0.125 sec  
T  = 20,000s  

Stable 15m/s [Ganesh Eagle]
--------------------
dx = 2.5 m  Lx=750m  
dy = 2.5 m  Ly=750m  
dz = 2.5 m  Lz=1000m  
dt = 0.0625 sec  
T  = 20,000s  (Run to 10k sec first, then start sampling)  


