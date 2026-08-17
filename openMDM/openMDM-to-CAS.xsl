<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:sys="http://www.omg.org/spec/CASCaRA/ontology/SystemsDesign/" xmlns:ver="http://www.omg.org/spec/CASCaRA/ontology/ProductVerification/" version="1">
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
				<!--VerificationRun-->
				<xsl:for-each select="//(*[local-name()='AoTest']|*[local-name()='AoSubTest']|*[local-name()='AoTestAbstract'])">
					<xsl:variable name="identifier">
						<xsl:value-of select="*[local-name()='Id']"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(*[local-name()='Name'])"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="*[local-name()='Id']"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="*[local-name()='Name']"/>
						</cas:Property>
						<cas:Property cas:hasClass="dateTime">
							<xsl:value-of select="*[local-name()='DateCreated']"/>
						</cas:Property>
						<cas:Property cas:hasClass="type">
							<xsl:value-of select="*[local-name()='Classification']"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="//(*[local-name()='AoTest']|*[local-name()='AoSubTest']|*[local-name()='AoTestAbstract'])">
					<xsl:variable name="identifier">
						<xsl:value-of select="*[local-name()='Id']"/>
					</xsl:variable>
					<!--VerificationRun.ownedBy.Actor-->
					<xsl:for-each select="*[local-name()='ResponsiblePerson']">
						<ver:VerificationRun_ownedBy_Actor>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_VerificationRun.ownedBy.Actor_',.)"/>
							</xsl:attribute>
							<ver:VerificationRun_ownedBy_Actor_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</ver:VerificationRun_ownedBy_Actor_Source>
							<ver:VerificationRun_ownedBy_Actor_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</ver:VerificationRun_ownedBy_Actor_Target>
						</ver:VerificationRun_ownedBy_Actor>
					</xsl:for-each>
				</xsl:for-each>
				<!--VerificationResource-->
				<xsl:for-each select="//*[contains(name(),'TestEquipment')]">
					<xsl:variable name="identifier">
						<xsl:value-of select="*[local-name()='Id']"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(*[local-name()='Name'])"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="*[local-name()='Id']"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="*[local-name()='Name']"/>
						</cas:Property>
						<cas:Property cas:hasClass="dateTime">
							<xsl:value-of select="*[local-name()='DateCreated']"/>
						</cas:Property>
						<cas:Property cas:hasClass="type">
							<xsl:value-of select="*[local-name()='Classification']"/>
						</cas:Property>
						<cas:Property cas:hasClass="revision">
							<xsl:value-of select="*[local-name()='Version']"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="//*[contains(name(),'TestEquipment')]">
					<xsl:variable name="identifier">
						<xsl:value-of select="*[local-name()='Id']"/>
					</xsl:variable>
					<!--SystemComponent.ownedBy.Actor-->
					<xsl:for-each select="*[local-name()='ResponsiblePerson']">
						<ver:SystemComponent_ownedBy_Actor>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.ownedBy.Actor_',.)"/>
							</xsl:attribute>
							<ver:SystemComponent_ownedBy_Actor_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</ver:SystemComponent_ownedBy_Actor_Source>
							<ver:SystemComponent_ownedBy_Actor_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</ver:SystemComponent_ownedBy_Actor_Target>
						</ver:SystemComponent_ownedBy_Actor>
					</xsl:for-each>
				</xsl:for-each>
				<!--VerificationResource-->
				<xsl:for-each select="//*[local-name()='TestEquipmentPart']">
					<xsl:variable name="identifier">
						<xsl:value-of select="*[local-name()='application_attribute'][name='Id']@uid"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(*[local-name()='Id']/*[local-name()='Identifier']/@id)"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="*[local-name()='application_attribute'][name='Id']@uid"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="*[local-name()='Id']/*[local-name()='Identifier']/@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="mass">
							<xsl:value-of select="*[local-name()='Versions']/*[local-name()='PartVersion']/*[local-name()='Views']/*[local-name()='PartView']/*[local-name()='PropertyValueAssignment']/*[local-name()='AssignedPropertyValues']/*[local-name()='PropertyValue'][./@uid='PRV--26']/*[local-name()='ValueComponent']/*[local-name()='CharacterString']"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="//*[local-name()='TestEquipmentPart']">
					<xsl:variable name="identifier">
						<xsl:value-of select="*[local-name()='application_attribute'][name='Id']@uid"/>
					</xsl:variable>
					<!--SystemComponent.partOf.SystemComponent-->
					<xsl:for-each select=".//*[local-name()='ViewOccurrenceRelationship']/*[local-name()='Related']/@uidRef">
						<ver:SystemComponent_partOf_SystemComponent>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.partOf.SystemComponent_',.)"/>
							</xsl:attribute>
							<ver:SystemComponent_partOf_SystemComponent_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</ver:SystemComponent_partOf_SystemComponent_Source>
							<ver:SystemComponent_partOf_SystemComponent_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</ver:SystemComponent_partOf_SystemComponent_Target>
						</ver:SystemComponent_partOf_SystemComponent>
					</xsl:for-each>
					<!--SystemComponent.usedIn.SystemComponent-->
					<xsl:for-each select=".//*[local-name()='Occurrence']/@uid">
						<ver:SystemComponent_usedIn_SystemComponent>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.usedIn.SystemComponent_',.)"/>
							</xsl:attribute>
							<ver:SystemComponent_usedIn_SystemComponent_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</ver:SystemComponent_usedIn_SystemComponent_Source>
							<ver:SystemComponent_usedIn_SystemComponent_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</ver:SystemComponent_usedIn_SystemComponent_Target>
						</ver:SystemComponent_usedIn_SystemComponent>
					</xsl:for-each>
					<!--SystemComponent.fulfils.Requirement-->
					<xsl:for-each select=".//*[local-name()='AssignedRequirement']/@uidRef">
						<ver:SystemComponent_fulfils_Requirement>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
							</xsl:attribute>
							<ver:SystemComponent_fulfils_Requirement_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</ver:SystemComponent_fulfils_Requirement_Source>
							<ver:SystemComponent_fulfils_Requirement_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</ver:SystemComponent_fulfils_Requirement_Target>
						</ver:SystemComponent_fulfils_Requirement>
					</xsl:for-each>
					<!--SystemComponent.fulfils.Requirement-->
					<xsl:for-each select="//*[local-name()='Requirement'][//*[local-name()='RequirementView']/@uid=$identifier]/*[local-name()='uid']">
						<ver:SystemComponent_fulfils_Requirement>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
							</xsl:attribute>
							<ver:SystemComponent_fulfils_Requirement_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</ver:SystemComponent_fulfils_Requirement_Source>
							<ver:SystemComponent_fulfils_Requirement_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</ver:SystemComponent_fulfils_Requirement_Target>
						</ver:SystemComponent_fulfils_Requirement>
					</xsl:for-each>
				</xsl:for-each>
				<!--SystemComponent-->
				<xsl:for-each select="//(*[local-name()='AoUnitUnderTest']|*[local-name()='AoUnitUnderTestPart'])">
					<xsl:variable name="identifier">
						<xsl:value-of select="*[local-name()='Id']"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(*[local-name()='Name'])"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="*[local-name()='Id']"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="*[local-name()='Name']"/>
						</cas:Property>
						<cas:Property cas:hasClass="dateTime">
							<xsl:value-of select="*[local-name()='DateCreated']"/>
						</cas:Property>
						<cas:Property cas:hasClass="type">
							<xsl:value-of select="*[local-name()='Classification']"/>
						</cas:Property>
					</cas:anEntity>
				</xsl:for-each>
				<xsl:for-each select="//(*[local-name()='AoUnitUnderTest']|*[local-name()='AoUnitUnderTestPart'])">
					<xsl:variable name="identifier">
						<xsl:value-of select="*[local-name()='Id']"/>
					</xsl:variable>
					<!--SystemComponent.ownedBy.Actor-->
					<xsl:for-each select="*[local-name()='ResponsiblePerson']">
						<sys:SystemComponent_ownedBy_Actor>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.ownedBy.Actor_',.)"/>
							</xsl:attribute>
							<sys:SystemComponent_ownedBy_Actor_Source>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</sys:SystemComponent_ownedBy_Actor_Source>
							<sys:SystemComponent_ownedBy_Actor_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</sys:SystemComponent_ownedBy_Actor_Target>
						</sys:SystemComponent_ownedBy_Actor>
					</xsl:for-each>
				</xsl:for-each>
			</graph>
		</cas:aPackage>
	</xsl:template>
</xsl:stylesheet>