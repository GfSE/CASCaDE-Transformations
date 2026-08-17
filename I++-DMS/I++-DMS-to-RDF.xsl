<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" xmlns:ver="http://www.omg.org/spec/CASCaRA/ontology/ProductVerification/" version="1">
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
				<dcterms:contributor>Michael Kirsch, :em engineering methods AG</dcterms:contributor>
				<dcterms:license>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
The software is provided 'as is', without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.
https://opensource.org/licenses/MIT</dcterms:license>
				<owl:imports rdf:resource="http://www.omg.org/spec/CASCaRA/ontology/"/>
			</owl:Ontology>
			<!--OrganizationUnit-->
			<xsl:for-each select="//*[local-name()='Company']">
				<xsl:variable name="identifier">
					<xsl:value-of select="."/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(.)"/>
				</xsl:variable>
				<org:OrganizationUnit>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="."/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="."/>
					</default:title>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Company']">
				<xsl:variable name="identifier">
					<xsl:value-of select="."/>
				</xsl:variable>
			</xsl:for-each>
			<!--VerificationPlan-->
			<xsl:for-each select="//*[local-name()='InspectionPlan']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<ver:VerificationPlan>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="*[local-name()='Comment']"/>
					</default:description>
				</ver:VerificationPlan>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InspectionPlan']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
			</xsl:for-each>
			<!--VerificationRun-->
			<xsl:for-each select="//*[local-name()='InspectionTask']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<ver:VerificationRun>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="*[local-name()='Description']"/>
					</default:description>
				</ver:VerificationRun>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='InspectionTask']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
			</xsl:for-each>
			<!--VerificationCharacteristic-->
			<xsl:for-each select="//*[local-name()='IPE']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<ver:VerificationCharacteristic>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="*[local-name()='Description']"/>
					</default:description>
					<default:type>
						<xsl:value-of select="@type"/>
					</default:type>
				</ver:VerificationCharacteristic>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='IPE']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='SystemID']/@uuid"/>
				</xsl:variable>
				<!--VerificationCharacteristic.partOf.VerificationPlan-->
				<xsl:for-each select="ancestor::InspectionPlan/*[local-name()='SystemID']/@uuid">
					<ver:VerificationCharacteristic_partOf_VerificationPlan>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_VerificationCharacteristic.partOf.VerificationPlan_',.)"/>
						</xsl:attribute>
						<ver:VerificationCharacteristic_partOf_VerificationPlan_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</ver:VerificationCharacteristic_partOf_VerificationPlan_Source>
						<ver:VerificationCharacteristic_partOf_VerificationPlan_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</ver:VerificationCharacteristic_partOf_VerificationPlan_Target>
					</ver:VerificationCharacteristic_partOf_VerificationPlan>
				</xsl:for-each>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>