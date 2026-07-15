<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:ee="http://www.omg.org/spec/CASCaRA/ontology/ElectricElectronicDesign/" xmlns:mech="http://www.omg.org/spec/CASCaRA/ontology/MechanicalDesign/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:variable name="packageUri">
				<xsl:value-of select="concat('http://www.example.org/', generate-id(), '/')"/>
			</xsl:variable>
			<owl:Ontology>
				<xsl:attribute name="rdf:about">
					<xsl:value-of select="$packageUri"/>
				</xsl:attribute>
				<owl:imports rdf:resource="http://www.omg.org/spec/CASCaRA/ontology/"/>
			</owl:Ontology>
			<!--ElectricElectronicComponent-->
			<xsl:for-each select="/*[local-name()='IPC-2581']/*[local-name()='Bom']/*[local-name()='BomItem']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@OEMDesignNumberRef"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@OEMDesignNumberRef)"/>
				</xsl:variable>
				<ee:ElectricElectronicComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@OEMDesignNumberRef"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@OEMDesignNumberRef"/>
					</default:title>
				</ee:ElectricElectronicComponent>
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
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Source>
						<ee:ElectricElectronicComponent_relatesTo_MechanicalComponent_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
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
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@refDes"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@part"/>
					</default:title>
				</mech:MechanicalComponent>
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
				<org:OrganizationUnit>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="@code"/>
					</default:number>
				</org:OrganizationUnit>
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
				<org:Person>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@name"/>
					</default:identifier>
					<default:lastname>
						<xsl:value-of select="@name"/>
					</default:lastname>
				</org:Person>
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
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</org:Person_memberOf_OrganizationUnit_Source>
						<org:Person_memberOf_OrganizationUnit_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
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
				<org:Role>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@roleFunction"/>
					</default:title>
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