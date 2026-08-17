<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:arch="http://www.omg.org/spec/CASCaRA/ontology/ProductArchitecture/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<cas:aPackage>
			<xsl:variable name="packageUri">
				<xsl:value-of select="concat('http://www.example.org/', generate-id(), '/')"/>
			</xsl:variable>
			<xsl:attribute name="id">
				<xsl:value-of select="$packageUri"/>
			</xsl:attribute>
			<dcterms:contributor>Michael Kirsch, :em engineering methods AG</dcterms:contributor>
			<dcterms:license>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
The software is provided 'as is', without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.
https://opensource.org/licenses/MIT</dcterms:license>
			<graph>
				<!--Requirement-->
				<xsl:for-each select="//*[local-name()='SPEC-OBJECT']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@IDENTIFIER"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(concat(*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.ForeignID']/@IDENTIFIER]/@THE-VALUE, ' ', *[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Name' or @LONG-NAME='ReqIF.ChapterName']/@IDENTIFIER]/*[local-name()='THE-VALUE']|@LONG-NAME))"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@IDENTIFIER"/>
						</cas:Property>
						<cas:Property cas:hasClass="number">
							<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.ForeignID']/@IDENTIFIER]/@THE-VALUE"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Name' or @LONG-NAME='ReqIF.ChapterName']/@IDENTIFIER]/*[local-name()='THE-VALUE']|@LONG-NAME"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Text']/@IDENTIFIER]/*[local-name()='THE-VALUE']"/>
						</cas:Property>
						<cas:Property cas:hasClass="type">
							<xsl:value-of select="*[local-name()='TYPE']/*[local-name()='SPEC-OBJECT-TYPE-REF']"/>
						</cas:Property>
						<cas:Property cas:hasClass="type">
							<xsl:value-of select="//*[local-name()='SPEC-OBJECT-TYPE'][@IDENTIFIER='$input']/@LONG-NAME"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="//*[local-name()='SPEC-OBJECT']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@IDENTIFIER"/>
					</xsl:variable>
					<!--Requirement.partOf.Requirement-->
					<xsl:for-each select="//*[local-name()='SPEC-HIERARCHY'][./*[local-name()='OBJECT']/*[local-name()='SPEC-OBJECT-REF']=$identifier]/*[local-name()='CHILDREN']/*[local-name()='SPEC-HIERARCHY']/*[local-name()='OBJECT']/*[local-name()='SPEC-OBJECT-REF']">
						<arch:Requirement_partOf_Requirement>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.partOf.Requirement_',.)"/>
							</xsl:attribute>
							<arch:Requirement_partOf_Requirement_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:Requirement_partOf_Requirement_Source>
							<arch:Requirement_partOf_Requirement_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</arch:Requirement_partOf_Requirement_Target>
						</arch:Requirement_partOf_Requirement>
					</xsl:for-each>
					<!--Requirement.specializes.Requirement-->
					<xsl:for-each select="//*[local-name()='SPEC-RELATION'][./*[local-name()='TYPE']/*[local-name()='SPEC-RELATION-TYPE-REF']=//*[local-name()='SPEC-RELATION-TYPE'][@LONG-NAME='Generalization']/@IDENTIFIER and ./*[local-name()='SOURCE']/*[local-name()='SPEC-OBJECT-REF']=$identifier]/*[local-name()='TARGET']/*[local-name()='SPEC-OBJECT-REF']">
						<arch:Requirement_specializes_Requirement>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.specializes.Requirement_',.)"/>
							</xsl:attribute>
							<arch:Requirement_specializes_Requirement_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:Requirement_specializes_Requirement_Source>
							<arch:Requirement_specializes_Requirement_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</arch:Requirement_specializes_Requirement_Target>
						</arch:Requirement_specializes_Requirement>
					</xsl:for-each>
					<!--Requirement.derivedFrom.Requirement-->
					<xsl:for-each select="//*[local-name()='SPEC-RELATION'][./*[local-name()='TYPE']/*[local-name()='SPEC-RELATION-TYPE-REF']=//*[local-name()='SPEC-RELATION-TYPE'][@LONG-NAME='realizes' or @LONG-NAME='Satisfy' or @LONG-NAME='Trace']/@IDENTIFIER and ./*[local-name()='SOURCE']/*[local-name()='SPEC-OBJECT-REF']=$identifier]/*[local-name()='TARGET']/*[local-name()='SPEC-OBJECT-REF']">
						<arch:Requirement_derivedFrom_Requirement>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.derivedFrom.Requirement_',.)"/>
							</xsl:attribute>
							<arch:Requirement_derivedFrom_Requirement_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:Requirement_derivedFrom_Requirement_Source>
							<arch:Requirement_derivedFrom_Requirement_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</arch:Requirement_derivedFrom_Requirement_Target>
						</arch:Requirement_derivedFrom_Requirement>
					</xsl:for-each>
					<!--Requirement.relatedTo.Requirement-->
					<xsl:for-each select="//*[local-name()='SPEC-RELATION'][./*[local-name()='TYPE']/*[local-name()='SPEC-RELATION-TYPE-REF']=//*[local-name()='SPEC-RELATION-TYPE'][@LONG-NAME='Association']/@IDENTIFIER and ./*[local-name()='SOURCE']/*[local-name()='SPEC-OBJECT-REF']=$identifier]/*[local-name()='TARGET']/*[local-name()='SPEC-OBJECT-REF']">
						<arch:Requirement_relatedTo_Requirement>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.relatedTo.Requirement_',.)"/>
							</xsl:attribute>
							<arch:Requirement_relatedTo_Requirement_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:Requirement_relatedTo_Requirement_Source>
							<arch:Requirement_relatedTo_Requirement_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</arch:Requirement_relatedTo_Requirement_Target>
						</arch:Requirement_relatedTo_Requirement>
					</xsl:for-each>
				</xsl:for-each>
			</graph>
		</cas:aPackage>
	</xsl:template>
</xsl:stylesheet>