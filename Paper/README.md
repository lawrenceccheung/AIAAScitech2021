# AIAA Scitech paper

## Paper sections

1. **Nomenclature** [`Lawrence`]
2. **Introduction** [`Lawrence`]
3. **Methodology**
    - A. Measured offshore conditions [`Lawrence`]
    - B. LES Codes
        - LES Formulation 
        - Boundary conditions
        - Nalu-Wind details [`Shreyas`]
        - AMR-Wind details [`Mike`]
    - C. Computational set up [`Lawrence`]
    - D. Simulation workflow [`Lawrence`]
4. **Results**  
    _This will be a joint effort from everyone_
    - A. Grid resolution study  
         _Do this study on stable 5m/s case_
    - B. AMR-Wind vs. Nalu-Wind comparison
    - C. Stable ABL physics
       - 1. ABL integrated quantities 
       - 2. Horizontally averaged profiles
       - 3. Wind spectra and turbulence statistics
5. **Conclusion** [`Lawrence`]

## File locations
- [`main.tex`](main.tex): Title, Introduction, Conclusion, etc.
- [`methodology.tex`](methodology.tex): Methodology section
- [`results.tex`](results.tex): Results section
- [`references.bib`](references.bib): Put references in here
- [`figures`](figures): Put all figures in here

## Compiling
Compile the latex document using these commands:
```bash
$ pdflatex main
$ bibtex main
$ pdflatex main
$ pdflatex main
```
