# beamer_template
A beamer template with a mechanism to autobuild using "inotifywait" and "make"

to use the automatic build :

This launcher wait until a tex file either in src either in figures/tikz is modify and build accordingly.
It also updates the document if the figure is modified.
$ ./scripts/make_launcher.sh

This launcher check only the src/ folder for tex files and figures/ for pdf files modifications
$ ./make_document_launcher.sh

This launcher check only the figures/tikz/ for tex files modifications
$ ./scripts/make_figure_launcher.sh

This launcher is launching 3 elements okular on the main pdf, kile for the edition of the tex and make_launcher.sh for automatic background build
$ ./scripts/edition.launch
