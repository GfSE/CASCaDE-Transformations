<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://omg.org/spec/CASCaRA/" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel/" xmlns:ee="http://omg.org/spec/CASCaRA/ElectricElectronicDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="/*[local-name()='KBL_container']/Accessory|/*[local-name()='KBL_container']/*[local-name()='Assembly_part']|/*[local-name()='KBL_container']/*[local-name()='Cavity_plug']|/*[local-name()='KBL_container']/*[local-name()='Cavity_seal']|/*[local-name()='KBL_container']/*[local-name()='Co_pack_part']|/*[local-name()='KBL_container']/*[local-name()='Component']|/*[local-name()='KBL_container']/*[local-name()='Component_box']|/*[local-name()='KBL_container']/Connector_housing|/*[local-name()='KBL_container']/*[local-name()='Fixing']|/*[local-name()='KBL_container']/*[local-name()='General_terminal']|/*[local-name()='KBL_container']/*[local-name()='General_wire']|/*[local-name()='KBL_container']/*[local-name()='Part_with_title_block']|/*[local-name()='KBL_container']/*[local-name()='Wire_protection']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ElectricElectronicComponent-->
				<ee:ElectricElectronicComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Part_number']"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="*[local-name()='Description']"/>
					</dc:description>
				</ee:ElectricElectronicComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='KBL_container']/Accessory|/*[local-name()='KBL_container']/*[local-name()='Assembly_part']|/*[local-name()='KBL_container']/*[local-name()='Cavity_plug']|/*[local-name()='KBL_container']/*[local-name()='Cavity_seal']|/*[local-name()='KBL_container']/*[local-name()='Co_pack_part']|/*[local-name()='KBL_container']/*[local-name()='Component']|/*[local-name()='KBL_container']/*[local-name()='Component_box']|/*[local-name()='KBL_container']/Connector_housing|/*[local-name()='KBL_container']/*[local-name()='Fixing']|/*[local-name()='KBL_container']/*[local-name()='General_terminal']|/*[local-name()='KBL_container']/*[local-name()='General_wire']|/*[local-name()='KBL_container']/*[local-name()='Part_with_title_block']|/*[local-name()='KBL_container']/*[local-name()='Wire_protection']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='KBL_container']/*[local-name()='General_wire']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ElectricElectronicConnection-->
				<ee:ElectricElectronicConnection>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Part_number']"/>
					</dc:title>
				</ee:ElectricElectronicConnection>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='KBL_container']/*[local-name()='General_wire']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>