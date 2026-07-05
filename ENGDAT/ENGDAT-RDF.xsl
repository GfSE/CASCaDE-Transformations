<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://omg.org/spec/CASCaRA/" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel/" xmlns:org="http://omg.org/spec/CASCaRA/Organization/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[local-name()='SDE' or local-name()='RDE']/*[local-name()='EngineeringContact']/*[local-name()='CompanyName']">
				<xsl:variable name="input">
					<xsl:value-of select="."/>
				</xsl:variable>
				<!--OrganizationUnit-->
				<org:OrganizationUnit>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="."/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="."/>
					</dc:title>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='SDE' or local-name()='RDE']/*[local-name()='EngineeringContact']/*[local-name()='CompanyName']">
				<xsl:variable name="input">
					<xsl:value-of select="."/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='SDE' or local-name()='RDE']/*[local-name()='EngineeringContact' or local-name()='TechnicalContact' or local-name()='TradingContact']">
				<xsl:variable name="input">
					<xsl:value-of select="./*[local-name()='RoutingCode']"/>
				</xsl:variable>
				<!--Person-->
				<org:Person>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="./*[local-name()='RoutingCode']"/>
					</dc:identifier>
				</org:Person>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='SDE' or local-name()='RDE']/*[local-name()='EngineeringContact' or local-name()='TechnicalContact' or local-name()='TradingContact']">
				<xsl:variable name="input">
					<xsl:value-of select="./*[local-name()='RoutingCode']"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>