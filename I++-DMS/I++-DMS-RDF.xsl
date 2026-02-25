<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:org="http://omg.org/spec/CASCaRA/Organization" xmlns:ver="http://omg.org/spec/CASCaRA/ProductVerification" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[local-name()='Company']">
				<xsl:variable name="input">
					<xsl:value-of select="."/>
				</xsl:variable>
				<!--OrganizationUnit-->
				<org:OrganizationUnit>
					<dc:identifier>
						<xsl:value-of select="."/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="."/>
					</dc:title>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InspectionPlan']">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<!--VerificationPlan-->
				<ver:VerificationPlan>
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
			<xsl:for-each select="//*[local-name()='InspectionTask']">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<!--VerificationRun-->
				<ver:VerificationRun>
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
			<xsl:for-each select="//*[local-name()='IPE']">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<!--VerificationCharacteristic-->
				<ver:VerificationCharacteristic>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="*[local-name()='Description']"/>
					</dc:description>
					<type>
						<xsl:value-of select="@type"/>
					</type>
					<!--VerificationCharacteristic relations-->
					<xsl:for-each select="ancestor::*[local-name()='InspectionPlan']/*[local-name()='SystemID']/@uuid">
						<VerificationCharacteristic.partOf.VerificationPlan>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</VerificationCharacteristic.partOf.VerificationPlan>
					</xsl:for-each>
				</ver:VerificationCharacteristic>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>