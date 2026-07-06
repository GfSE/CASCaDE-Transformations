<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns="http://omg.org/spec/CASCaRA/" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel/" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[local-name()='ScalarVariable']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@valueReference"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--ComponentInterface-->
				<sys:ComponentInterface>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@valueReference"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@description"/>
					</dc:description>
				</sys:ComponentInterface>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='ScalarVariable']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@valueReference"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>