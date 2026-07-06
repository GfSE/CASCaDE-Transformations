<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns="http://omg.org/spec/CASCaRA/" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel/" xmlns:ee="http://omg.org/spec/CASCaRA/ElectricElectronicDesign/" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign/" xmlns:org="http://omg.org/spec/CASCaRA/Organization/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Bom']/*[local-name()='BomItem']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@OEMDesignNumberRef"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@OEMDesignNumberRef"/>
				</xsl:variable>
				<!--ElectricElectronicComponent-->
				<ee:ElectricElectronicComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@OEMDesignNumberRef"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@OEMDesignNumberRef"/>
					</dc:title>
				</ee:ElectricElectronicComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Bom']/*[local-name()='BomItem']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@OEMDesignNumberRef"/>
				</xsl:variable>
				<!--ElectricElectronicComponent relations-->
				<xsl:for-each select="*[local-name()='RefDes']/@name">
					<ee:ElectricElectronicComponent_relatesTo_MechanicalComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_ElectricElectronicComponent.relatesTo.MechanicalComponent_',.)"/>
						</xsl:attribute>
						<ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Source>
							<xsl:value-of select="$input"/>
						</ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Source>
						<ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Target>
							<xsl:value-of select="."/>
						</ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Target>
					</ee:ElectricElectronicComponent_relatesTo_MechanicalComponent>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Ecad']/*[local-name()='CadData']/*[local-name()='Step']/*[local-name()='Component']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@refDes"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@part"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@refDes"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@part"/>
					</dc:title>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Ecad']/*[local-name()='CadData']/*[local-name()='Step']/*[local-name()='Component']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@refDes"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Enterprise']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@code"/>
				</xsl:variable>
				<!--OrganizationUnit-->
				<org:OrganizationUnit>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<number xmlns="">
						<xsl:value-of select="@code"/>
					</number>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Enterprise']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Person']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--Person-->
				<org:Person>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@name"/>
					</dc:identifier>
					<lastname xmlns="">
						<xsl:value-of select="@name"/>
					</lastname>
				</org:Person>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Person']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--Person relations-->
				<xsl:for-each select="@enterpriseRef">
					<org:Person_memberOf_OrganizationUnit>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Person.memberOf.OrganizationUnit_',.)"/>
						</xsl:attribute>
						<org:Person_memberOf_OrganizationUnit_Source>
							<xsl:value-of select="$input"/>
						</org:Person_memberOf_OrganizationUnit_Source>
						<org:Person_memberOf_OrganizationUnit_Target>
							<xsl:value-of select="."/>
						</org:Person_memberOf_OrganizationUnit_Target>
					</org:Person_memberOf_OrganizationUnit>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Role']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@roleFunction"/>
				</xsl:variable>
				<!--Role-->
				<org:Role>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@roleFunction"/>
					</dc:title>
				</org:Role>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='LogisticHeader']/*[local-name()='Role']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>