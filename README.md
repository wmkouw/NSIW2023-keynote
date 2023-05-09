# NSIW2023-keynote

Companion repository for the keynote talk titled "Variational Bayesian inference for System Identification" at the [Nonlinear System Identification Workshop 2023](https://www.nonlinearbenchmark.org/workshop) in Eindhoven.

## Demonstration

The `code` folder contains a Jupyter notebook detailing the demonstration system along with julia code and figures. To run the notebook, install Jupyter, download a julia kernel (v1.8+), and run:
```julia
using Pkg
Pkg.add("IJulia")
```
That will add the julia kernel to jupyter automatically. Alternatively, consider installing [Visual Studio Code](https://code.visualstudio.com/insiders/) and adding the [Jupyter](https://devblogs.microsoft.com/python/introducing-the-jupyter-extension-for-vs-code/) and [Julia](https://code.visualstudio.com/docs/languages/julia) extensions.

If you're not interested in running the notebook, but would just like to view it, open the `.html` version in your browser. It should render with all the figures and results.

## References:
- Kouw, Podusenko, Koudahl & Schoukens (2022). Variational message passing for online polynomial NARMAX identification. _American Control Conference_, DOI: [10.23919/ACC53348.2022.9867898](https://doi.org/10.23919/ACC53348.2022.9867898).
- Podusenko, Akbayrak, Senöz, Schoukens & Kouw (2022). Message passing-based system identification for NARMAX models. _IEEE Conference on Decision & Control_, DOI: [10.1109/CDC51059.2022.9992891](https://doi.org/10.1109/CDC51059.2022.9992891).
- Senöz, van de Laar, Bagaev & de Vries (2021). Variational message passing and local constraint manipulation in factor graphs. _Entropy_, DOI: [10.3390/e23070807](https://doi.org/10.3390/e23070807).
- Van de Laar (2021). Chance-constrained active inference. _Neural Computation_, DOI: [10.1162/neco_a_01427](https://doi.org/10.1162/neco_a_01427).
- Dauwels (2007). On variational message passing on factor graphs. _IEEE International Symposium on Information Theory_, DOI: [10.1109/ISIT.2007.4557602](https://doi.org/10.1109/ISIT.2007.4557602).


