# The GAP 4 package `AttributeScheduler`

This packages contains methods to construct a graph to compute attributes with dependencies. This means that the graph describes which attribute implies other attributes.

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

## License
AttributeScheduler is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version. 
For details see the LICENSE file.
