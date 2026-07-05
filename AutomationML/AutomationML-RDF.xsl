<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://omg.org/spec/CASCaRA/" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel/" xmlns:ee="http://omg.org/spec/CASCaRA/ElectricElectronicDesign/" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[local-name()='InternalElement'][./*[local-name()='RoleRequirements'][@RefBaseRoleClassPath='AutomationMLBaseRoleClassLib/AutomationMLBaseRole/Port']">
				<xsl:variable name="input">
					<xsl:value-of select="@ID"/>
				</xsl:variable>
				<!--ElectricElectronicPort-->
				<ee:ElectricElectronicPort>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@ID"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@Name"/>
					</dc:title>
				</ee:ElectricElectronicPort>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InternalElement'][./*[local-name()='RoleRequirements'][@RefBaseRoleClassPath='AutomationMLBaseRoleClassLib/AutomationMLBaseRole/Port']">
				<xsl:variable name="input">
					<xsl:value-of select="@ID"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InternalElement'][./*[local-name()='RoleRequirements'][@RefBaseRoleClassPath='AutomationMLBaseRoleClassLib/AutomationMLBaseRole/Product']">
				<xsl:variable name="input">
					<xsl:value-of select="@ID"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@ID"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@Name"/>
					</dc:title>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InternalElement'][./*[local-name()='RoleRequirements'][@RefBaseRoleClassPath='AutomationMLBaseRoleClassLib/AutomationMLBaseRole/Product']">
				<xsl:variable name="input">
					<xsl:value-of select="@ID"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>