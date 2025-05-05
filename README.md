# The GAP 4 package `AttributeScheduler`

This packages contains methods to construct a graph to compute attributes with dependencies. This means that the graph describes which attribute implies other attributes.

## License
TODO

## Installation
To use this package, go into your local installation directory for GAP (often located under `~/.gap/` ), and clone this repository in the `pkg/`-subfolder:

    cd pkg/
    git clone https://github.com/gap-packages/AttributeScheduler

Another option for installation is the use of `PackageManager`:

    LoadPackage("PackageManager");
    InstallPackage("https://github.com/gap-packages/AttributeScheduler.git");
    
For using the Package, call

    LoadPackage("AttributeScheduler");

to access the package inside a GAP session.
