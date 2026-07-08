<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" xmlns:ver="http://www.omg.org/spec/CASCaRA/ontology/ProductVerification/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<owl:Ontology>
				<xsl:attribute name="rdf:about">
					<xsl:value-of select="concat('http://www.example.org/', generate-id(), '/')"/>
				</xsl:attribute>
				<owl:imports rdf:resource="http://www.omg.org/spec/CASCaRA/ontology/"/>
			</owl:Ontology>
			<xsl:for-each select="//*[local-name()='Company']">
				<xsl:variable name="identifier">
					<xsl:value-of select="."/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(.)"/>
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
						<xsl:value-of select="."/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="."/>
					</dc:title>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Company']">
				<xsl:variable name="identifier">
					<xsl:value-of select="."/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InspectionPlan']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<!--VerificationPlan-->
				<ver:VerificationPlan>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="*[local-name()='Comment']"/>
					</dc:description>
				</ver:VerificationPlan>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InspectionPlan']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InspectionTask']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<!--VerificationRun-->
				<ver:VerificationRun>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="*[local-name()='Description']"/>
					</dc:description>
				</ver:VerificationRun>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InspectionTask']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='IPE']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<!--VerificationCharacteristic-->
				<ver:VerificationCharacteristic>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="*[local-name()='Description']"/>
					</dc:description>
					<default:type>
						<xsl:value-of select="@type"/>
					</default:type>
				</ver:VerificationCharacteristic>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='IPE']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<!--VerificationCharacteristic relations-->
				<xsl:for-each select="ancestor::InspectionPlan/*[local-name()='SystemID']/@uuid">
					<ver:VerificationCharacteristic_partOf_VerificationPlan>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_VerificationCharacteristic.partOf.VerificationPlan_',.)"/>
						</xsl:attribute>
						<ver:VerificationCharacteristic_partOf_VerificationPlan_Source>
							<xsl:value-of select="$input"/>
						</ver:VerificationCharacteristic_partOf_VerificationPlan_Source>
						<ver:VerificationCharacteristic_partOf_VerificationPlan_Target>
							<xsl:value-of select="."/>
						</ver:VerificationCharacteristic_partOf_VerificationPlan_Target>
					</ver:VerificationCharacteristic_partOf_VerificationPlan>
				</xsl:for-each>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>