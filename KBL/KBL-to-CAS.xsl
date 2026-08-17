<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:kbl="http://www.prostep.org/Car_electric_container/KBL2.3/KBLSchema" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:ee="http://www.omg.org/spec/CASCaRA/ontology/ElectricElectronicDesign/" version="1">
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
				<!--ElectricElectronicComponent-->
				<xsl:for-each select="/*[local-name()='KBL_container']/Connector_housing">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(*[local-name()='Part_number'])"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="*[local-name()='Part_number']"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="*[local-name()='Description']"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="/*[local-name()='KBL_container']/Connector_housing">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
					<!--SystemComponent.partOf.SystemComponent-->
					<xsl:for-each select="./*/@xmi:id">
						<ee:SystemComponent_partOf_SystemComponent>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.partOf.SystemComponent_',.)"/>
							</xsl:attribute>
							<ee:SystemComponent_partOf_SystemComponent_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</ee:SystemComponent_partOf_SystemComponent_Source>
							<ee:SystemComponent_partOf_SystemComponent_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</ee:SystemComponent_partOf_SystemComponent_Target>
						</ee:SystemComponent_partOf_SystemComponent>
					</xsl:for-each>
					<!--SystemComponent.specializes.SystemComponent-->
					<xsl:for-each select="*[local-name()='generalization']/@general">
						<ee:SystemComponent_specializes_SystemComponent>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.specializes.SystemComponent_',.)"/>
							</xsl:attribute>
							<ee:SystemComponent_specializes_SystemComponent_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</ee:SystemComponent_specializes_SystemComponent_Source>
							<ee:SystemComponent_specializes_SystemComponent_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</ee:SystemComponent_specializes_SystemComponent_Target>
						</ee:SystemComponent_specializes_SystemComponent>
					</xsl:for-each>
				</xsl:for-each>
				<!--ElectricElectronicComponent-->
				<xsl:for-each select="/*[local-name()='KBL_container']/Accessory|/*[local-name()='KBL_container']/*[local-name()='Assembly_part']|/*[local-name()='KBL_container']/*[local-name()='Cavity_plug']|/*[local-name()='KBL_container']/*[local-name()='Cavity_seal']|/*[local-name()='KBL_container']/*[local-name()='Co_pack_part']|/*[local-name()='KBL_container']/*[local-name()='Component']|/*[local-name()='KBL_container']/*[local-name()='Component_box']|/*[local-name()='KBL_container']/Connector_housing|/*[local-name()='KBL_container']/*[local-name()='Fixing']|/*[local-name()='KBL_container']/*[local-name()='General_terminal']|/*[local-name()='KBL_container']/*[local-name()='General_wire']|/*[local-name()='KBL_container']/*[local-name()='Part_with_title_block']|/*[local-name()='KBL_container']/*[local-name()='Wire_protection']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(*[local-name()='Part_number'])"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="*[local-name()='Part_number']"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="*[local-name()='Description']"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="/*[local-name()='KBL_container']/Accessory|/*[local-name()='KBL_container']/*[local-name()='Assembly_part']|/*[local-name()='KBL_container']/*[local-name()='Cavity_plug']|/*[local-name()='KBL_container']/*[local-name()='Cavity_seal']|/*[local-name()='KBL_container']/*[local-name()='Co_pack_part']|/*[local-name()='KBL_container']/*[local-name()='Component']|/*[local-name()='KBL_container']/*[local-name()='Component_box']|/*[local-name()='KBL_container']/Connector_housing|/*[local-name()='KBL_container']/*[local-name()='Fixing']|/*[local-name()='KBL_container']/*[local-name()='General_terminal']|/*[local-name()='KBL_container']/*[local-name()='General_wire']|/*[local-name()='KBL_container']/*[local-name()='Part_with_title_block']|/*[local-name()='KBL_container']/*[local-name()='Wire_protection']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
				</xsl:for-each>
				<!--ElectricElectronicConnection-->
				<xsl:for-each select="/*[local-name()='KBL_container']/*[local-name()='General_wire']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(*[local-name()='Part_number'])"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="*[local-name()='Part_number']"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="/*[local-name()='KBL_container']/*[local-name()='General_wire']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
				</xsl:for-each>
			</graph>
		</cas:aPackage>
	</xsl:template>
</xsl:stylesheet>