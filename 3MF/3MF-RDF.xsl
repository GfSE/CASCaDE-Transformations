<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[local-name()='resources']/*[local-name()='object']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<!--MechanicalComponent relations-->
					<xsl:for-each select="./*[local-name()='components']/*[local-name()='component']/@objectid">
						<SystemComponent.usedIn.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.usedIn.SystemComponent>
					</xsl:for-each>
				</mech:MechanicalComponent>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>