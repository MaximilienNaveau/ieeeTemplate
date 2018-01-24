to use the automatic build :

This launcher wait until a tex file eaither in src either in figures/tikz is modify and build accordingly.
It also updates the document if the figure is modified.
$ ./make_launcher.sh

This launcher check only the src/ for tex files and figures/ for pdf files modifications
$ ./make_document_launcher.sh

This launcher check only the figures/tikz/ for tex files modifications
$ ./make_figure_launcher.sh

This launcher is launching 3 elements okular on the main pdf, kile for the edition of the tex and make_launcher.sh for automatic background build
