nlgis2
======

The aim of the nlgis2 project is to reestablish the services provided by the nlgis project. The original nlgis project allowed researchers to upload data on characteristics of Dutch municipalities in the 19th and 20th century and plot that data on a map using Onno Boonstra's shapefiles ([urn:nbn:nl:ui:13-wsh-wv7]). In addition, nlgis2 aims to provide an R-package to easily plot such data in the R-environment using existing packages. Finally, there are various datasets on municipality characteristics that we aim to provide through a webservice.

The nlgis2 project is made possible by a Dans Small Data Project grant [http://www.dans.knaw.nl/en/content/projects/small-data-projects] and is executed by members of the International Institute of Social History [http://socialhistory.org]. The project closely collaborates with the Hic Sunt Leones group who were also awarded a Small Data Project grant to extent the existing shapefiles by making them available through RDF [http://www.hicsuntleones.nl]. 
## R
In addition to the NLGIS website [http://nlgis.nl](http://nlgis.nl), the data and maps are accessible through an API. For R there's also a convenience package to connect to the API and plot data on the map. To install the package:
```{r}
    install.packages("devtools")  
    library(devtools)  
    install_github("rlzijdeman/nlgis2", subdir = "/scripts/etl/R/package/nlgis")  
    library(nlgis)
    ?nlgis # To check the documentation
```
