<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[local-name()='resources']/*[local-name()='object']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='resources']/*[local-name()='object']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--MechanicalComponent relations-->
				<xsl:for-each select="./*[local-name()='components']/*[local-name()='component']/@objectid">
					<mech:SystemComponent_usedIn_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.usedIn.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_usedIn_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_usedIn_SystemComponent_Source>
						<mech:SystemComponent_usedIn_SystemComponent_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_usedIn_SystemComponent_Target>
					</mech:SystemComponent_usedIn_SystemComponent>
				</xsl:for-each>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>