## Transformation ReqIF -> CASCaRA XML

### ReqIF-to-CAS.xsl

A stylesheet for XSL-Transformation (XSLT) from ReqIF to CASCaRA XML. Extracts:
- ATTRIBUTE-DEFINITION -> cas:Property
- SPEC-OBJECT-TYPE -> cas:Entity
- SPEC-RELATION-TYPE -> cas:Relationship
- SPECIFICATION-TYPE -> cas:Entity specializing cas:Root
- SPEC-OBJECT -> cas:anEntity
- SPEC-RELATION -> cas:aRelationship
- SPECIFICATION -> cas:anEntity

Limitations - does not extract:
- Data ranges as defined in the ATTRIBUTE-DEFINITION
- Any ATTRIBUTE other than title and description
- The hierarchy nodes creating the tree

### ReqIF-to-CAS.sef.json

Created from the above for use with the CASCaRA Validation Tool (Reference Implementation). 
The need for this format arises from the open-source transformation library Saxon-JS, 
which does not support the native .xsl format. 

### CASCaRA Validation Tool

This transformation is available in the [CASCaRA Validation Tool](https://app-alpha.product-information-graph.org/interfaces). 
Please test it with your data ... and if you run into a problem, have a suggestion or 
even a question, please open an [issue on GitHub](https://github.com/GfSE/CASCaDE-Transformations/issues).

### Transformation via SpecIF

The open-source [SpecIF Editor](https://specif.de/apps/edit.html) offers a full
transformation from ReqIF. Any SpecIF data can be transformed on export to
CASCaRA JSON-LD (*.cas.jsonld) which in turn can be imported by the the
[CASCaRA Validation Tool](https://app-alpha.product-information-graph.org/).

### Issues
... and suggestions: Please submit via [GitHub Issues](https://github.com/GfSE/CASCaDE-Transformations/issues).

### Author
- [Dr. Oskar v. Dungern](mailto:od@enso-managers.de) for [GfSE](https://gfse.org) (German Chapter of INCOSE).

### License
... and terms of use: [Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0).
