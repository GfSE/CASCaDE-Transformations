<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:ee="http://omg.org/spec/CASCaRA/ElectricElectronicDesign" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign" xmlns:org="http://omg.org/spec/CASCaRA/Organization" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Bom']/*[local-name()='BomItem']">
				<xsl:variable name="input">
					<xsl:value-of select="@OEMDesignNumberRef"/>
				</xsl:variable>
				<!--ElectricElectronicComponent-->
				<ee:ElectricElectronicComponent>
					<dc:identifier>
						<xsl:value-of select="@OEMDesignNumberRef"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@OEMDesignNumberRef"/>
					</dc:title>
					<!--ElectricElectronicComponent relations-->
					<xsl:for-each select="*[local-name()='RefDes']/@name">
						<ElectricElectronicComponent.relatesTo.MechanicalComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</ElectricElectronicComponent.relatesTo.MechanicalComponent>
					</xsl:for-each>
				</ee:ElectricElectronicComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Ecad']/*[local-name()='CadData']/*[local-name()='Step']/*[local-name()='Component']">
				<xsl:variable name="input">
					<xsl:value-of select="@refDes"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<dc:identifier>
						<xsl:value-of select="@refDes"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@part"/>
					</dc:title>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Enterprise']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--OrganizationUnit-->
				<org:OrganizationUnit>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<number>
						<xsl:value-of select="@code"/>
					</number>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Person']">
				<xsl:variable name="input">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--Person-->
				<org:Person>
					<dc:identifier>
						<xsl:value-of select="@name"/>
					</dc:identifier>
					<lastname>
						<xsl:value-of select="@name"/>
					</lastname>
					<!--Person relations-->
					<xsl:for-each select="@enterpriseRef">
						<Person.memberOf.OrganizationUnit>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Person.memberOf.OrganizationUnit>
					</xsl:for-each>
				</org:Person>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Role']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Role-->
				<org:Role>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@roleFunction"/>
					</dc:title>
				</org:Role>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>