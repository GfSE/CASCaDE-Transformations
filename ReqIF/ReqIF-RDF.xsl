<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel" xmlns:arch="http://omg.org/spec/CASCaRA/ProductArchitecture/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[local-name()='SPEC-OBJECT']">
				<xsl:variable name="input">
					<xsl:value-of select="@IDENTIFIER"/>
				</xsl:variable>
				<!--Requirement-->
				<arch:Requirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@IDENTIFIER"/>
					</dc:identifier>
					<number>
						<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.ForeignID']/@IDENTIFIER]/@THE-VALUE"/>
					</number>
					<dc:title>
						<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Name' or @LONG-NAME='ReqIF.ChapterName']/@IDENTIFIER]/*[local-name()='THE-VALUE']|@LONG-NAME"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Text']/@IDENTIFIER]/*[local-name()='THE-VALUE']"/>
					</dc:description>
					<type>
						<xsl:value-of select="*[local-name()='TYPE']/*[local-name()='SPEC-OBJECT-TYPE-REF']"/>
					</type>
					<type>
						<xsl:value-of select="//*[local-name()='SPEC-OBJECT-TYPE'][@IDENTIFIER='$input']/@LONG-NAME"/>
					</type>
				</arch:Requirement>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='SPEC-OBJECT']">
				<xsl:variable name="input">
					<xsl:value-of select="@IDENTIFIER"/>
				</xsl:variable>
				<!--Requirement relations-->
				<xsl:for-each select="//*[local-name()='SPEC-HIERARCHY'][./*[local-name()='OBJECT']/*[local-name()='SPEC-OBJECT-REF']=$input]/*[local-name()='CHILDREN']/*[local-name()='SPEC-HIERARCHY']/*[local-name()='OBJECT']/*[local-name()='SPEC-OBJECT-REF']">
					<arch:Requirement_partOf_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.partOf.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_partOf_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_partOf_Requirement_Target>
					</arch:Requirement_partOf_Requirement>
				</xsl:for-each>
				<!--Requirement relations-->
				<xsl:for-each select="//*[local-name()='SPEC-RELATION'][./*[local-name()='TYPE']/*[local-name()='SPEC-RELATION-TYPE-REF']=//*[local-name()='SPEC-RELATION-TYPE'][@LONG-NAME='Generalization']/@IDENTIFIER and ./*[local-name()='SOURCE']/*[local-name()='SPEC-OBJECT-REF']=$input]/*[local-name()='TARGET']/*[local-name()='SPEC-OBJECT-REF']">
					<arch:Requirement_specializes_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.specializes.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_specializes_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_specializes_Requirement_Source>
						<arch:Requirement_specializes_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_specializes_Requirement_Target>
					</arch:Requirement_specializes_Requirement>
				</xsl:for-each>
				<!--Requirement relations-->
				<xsl:for-each select="//*[local-name()='SPEC-RELATION'][./*[local-name()='TYPE']/*[local-name()='SPEC-RELATION-TYPE-REF']=//*[local-name()='SPEC-RELATION-TYPE'][@LONG-NAME='realizes' or @LONG-NAME='Satisfy' or @LONG-NAME='Trace']/@IDENTIFIER and ./*[local-name()='SOURCE']/*[local-name()='SPEC-OBJECT-REF']=$input]/*[local-name()='TARGET']/*[local-name()='SPEC-OBJECT-REF']">
					<arch:Requirement_derivedFrom_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.derivedFrom.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_derivedFrom_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_derivedFrom_Requirement_Source>
						<arch:Requirement_derivedFrom_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_derivedFrom_Requirement_Target>
					</arch:Requirement_derivedFrom_Requirement>
				</xsl:for-each>
				<!--Requirement relations-->
				<xsl:for-each select="//*[local-name()='SPEC-RELATION'][./*[local-name()='TYPE']/*[local-name()='SPEC-RELATION-TYPE-REF']=//*[local-name()='SPEC-RELATION-TYPE'][@LONG-NAME='Association']/@IDENTIFIER and ./*[local-name()='SOURCE']/*[local-name()='SPEC-OBJECT-REF']=$input]/*[local-name()='TARGET']/*[local-name()='SPEC-OBJECT-REF']">
					<arch:Requirement_relatedTo_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.relatedTo.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_relatedTo_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_relatedTo_Requirement_Source>
						<arch:Requirement_relatedTo_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_relatedTo_Requirement_Target>
					</arch:Requirement_relatedTo_Requirement>
				</xsl:for-each>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>