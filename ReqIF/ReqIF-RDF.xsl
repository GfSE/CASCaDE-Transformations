<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:arch="http://www.omg.org/spec/CASCaRA/ontology/ProductArchitecture/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:variable name="packageUri">
				<xsl:value-of select="concat('http://www.example.org/', generate-id(), '/')"/>
			</xsl:variable>
			<owl:Ontology>
				<xsl:attribute name="rdf:about">
					<xsl:value-of select="$packageUri"/>
				</xsl:attribute>
				<owl:imports rdf:resource="http://www.omg.org/spec/CASCaRA/ontology/"/>
			</owl:Ontology>
			<!--Requirement-->
			<xsl:for-each select="//*[local-name()='SPEC-OBJECT']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@IDENTIFIER"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.ForeignID']/@IDENTIFIER]/@THE-VALUE, ' ', *[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Name' or @LONG-NAME='ReqIF.ChapterName']/@IDENTIFIER]/*[local-name()='THE-VALUE']|@LONG-NAME))"/>
				</xsl:variable>
				<arch:Requirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@IDENTIFIER"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.ForeignID']/@IDENTIFIER]/@THE-VALUE"/>
					</default:number>
					<default:title>
						<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Name' or @LONG-NAME='ReqIF.ChapterName']/@IDENTIFIER]/*[local-name()='THE-VALUE']|@LONG-NAME"/>
					</default:title>
					<default:description>
						<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Text']/@IDENTIFIER]/*[local-name()='THE-VALUE']"/>
					</default:description>
					<default:type>
						<xsl:value-of select="*[local-name()='TYPE']/*[local-name()='SPEC-OBJECT-TYPE-REF']"/>
					</default:type>
					<default:type>
						<xsl:value-of select="//*[local-name()='SPEC-OBJECT-TYPE'][@IDENTIFIER='$input']/@LONG-NAME"/>
					</default:type>
				</arch:Requirement>
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
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
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
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:Requirement_specializes_Requirement_Source>
						<arch:Requirement_specializes_Requirement_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
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
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:Requirement_derivedFrom_Requirement_Source>
						<arch:Requirement_derivedFrom_Requirement_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
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
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:Requirement_relatedTo_Requirement_Source>
						<arch:Requirement_relatedTo_Requirement_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</arch:Requirement_relatedTo_Requirement_Target>
					</arch:Requirement_relatedTo_Requirement>
				</xsl:for-each>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>