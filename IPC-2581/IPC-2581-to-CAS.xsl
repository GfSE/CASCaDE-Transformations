<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:ee="http://www.omg.org/spec/CASCaRA/ontology/ElectricElectronicDesign/" xmlns:mech="http://www.omg.org/spec/CASCaRA/ontology/MechanicalDesign/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" version="1">
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
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Bom']/*[local-name()='BomItem']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@OEMDesignNumberRef"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(@OEMDesignNumberRef)"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@OEMDesignNumberRef"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="@OEMDesignNumberRef"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Bom']/*[local-name()='BomItem']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@OEMDesignNumberRef"/>
					</xsl:variable>
					<!--ElectricElectronicComponent.relatesTo.MechanicalComponent-->
					<xsl:for-each select="*[local-name()='RefDes']/@name">
						<ee:ElectricElectronicComponent_relatesTo_MechanicalComponent>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_ElectricElectronicComponent.relatesTo.MechanicalComponent_',.)"/>
							</xsl:attribute>
							<ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Source>
							<ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Target>
						</ee:ElectricElectronicComponent_relatesTo_MechanicalComponent>
					</xsl:for-each>
				</xsl:for-each>
				<!--MechanicalComponent-->
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Ecad']/*[local-name()='CadData']/*[local-name()='Step']/*[local-name()='Component']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@refDes"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(@part)"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@refDes"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="@part"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Ecad']/*[local-name()='CadData']/*[local-name()='Step']/*[local-name()='Component']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@refDes"/>
					</xsl:variable>
				</xsl:for-each>
				<!--OrganizationUnit-->
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Enterprise']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(@code)"/>
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
						<cas:Property cas:hasClass="number">
							<xsl:value-of select="@code"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Enterprise']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
				</xsl:for-each>
				<!--Person-->
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Person']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@name"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(@name)"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@name"/>
						</cas:Property>
						<cas:Property cas:hasClass="lastname">
							<xsl:value-of select="@name"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Person']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@name"/>
					</xsl:variable>
					<!--Person.memberOf.OrganizationUnit-->
					<xsl:for-each select="@enterpriseRef">
						<org:Person_memberOf_OrganizationUnit>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_Person.memberOf.OrganizationUnit_',.)"/>
							</xsl:attribute>
							<org:Person_memberOf_OrganizationUnit_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</org:Person_memberOf_OrganizationUnit_Source>
							<org:Person_memberOf_OrganizationUnit_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</org:Person_memberOf_OrganizationUnit_Target>
						</org:Person_memberOf_OrganizationUnit>
					</xsl:for-each>
				</xsl:for-each>
				<!--Role-->
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Role']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(@roleFunction)"/>
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
							<xsl:value-of select="@roleFunction"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Role']">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
				</xsl:for-each>
			</graph>
		</cas:aPackage>
	</xsl:template>
</xsl:stylesheet>