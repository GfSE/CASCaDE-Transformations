<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[local-name()='ScalarVariable']">
				<xsl:variable name="input">
					<xsl:value-of select="@valueReference"/>
				</xsl:variable>
				<!--ComponentInterface-->
				<sys:ComponentInterface>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
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
				<xsl:variable name="input">
					<xsl:value-of select="@valueReference"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>