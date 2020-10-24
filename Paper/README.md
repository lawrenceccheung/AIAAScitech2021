# AIAA Scitech paper

## Paper sections

1. **Nomenclature** [`Lawrence`]
2. **Introduction** [`Lawrence`]
3. **Methodology**
    - A. Measured offshore conditions [`Lawrence`]
    - B. LES Codes
        - 1. Nalu-Wind [`Shreyas`]
        - 2. AMR-Wind [`Mike`]
    - C. Computational set up [`Lawrence`]
    - D. Lower wall model BC [`Ganesh`]
    - E. Simulation workflow
4. **Results**  
    _This will be a joint effort from everyone_
    - A. ABL integrated quantities 
    - B. Horizontally averaged profiles
    - C. Wind spectra and turbulence statistics
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
