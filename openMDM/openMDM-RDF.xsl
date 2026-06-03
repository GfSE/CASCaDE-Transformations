<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign" xmlns:ver="http://omg.org/spec/CASCaRA/ProductVerification" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//(*[local-name()='AoTest']|*[local-name()='AoSubTest']|*[local-name()='AoTestAbstract'])">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Id']"/>
				</xsl:variable>
				<!--VerificationRun-->
				<ver:VerificationRun>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='Id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Name']"/>
					</dc:title>
					<dateTime>
						<xsl:value-of select="*[local-name()='DateCreated']"/>
					</dateTime>
					<type>
						<xsl:value-of select="*[local-name()='Classification']"/>
					</type>
					<!--VerificationRun relations-->
					<xsl:for-each select="*[local-name()='ResponsiblePerson']">
						<VerificationRun.ownedBy.Actor>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</VerificationRun.ownedBy.Actor>
					</xsl:for-each>
				</ver:VerificationRun>
			</xsl:for-each>
			<xsl:for-each select="//*[contains(name(),'TestEquipment')]">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Id']"/>
				</xsl:variable>
				<!--VerificationResource-->
				<ver:VerificationResource>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='Id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Name']"/>
					</dc:title>
					<dateTime>
						<xsl:value-of select="*[local-name()='DateCreated']"/>
					</dateTime>
					<type>
						<xsl:value-of select="*[local-name()='Classification']"/>
					</type>
					<revision>
						<xsl:value-of select="*[local-name()='Version']"/>
					</revision>
					<!--VerificationResource relations-->
					<xsl:for-each select="*[local-name()='ResponsiblePerson']">
						<SystemComponent.ownedBy.Actor>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.ownedBy.Actor>
					</xsl:for-each>
				</ver:VerificationResource>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='TestEquipmentPart']">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='application_attribute'][name='Id']@uid"/>
				</xsl:variable>
				<!--VerificationResource-->
				<ver:VerificationResource>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='application_attribute'][name='Id']@uid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Id']/*[local-name()='Identifier']/@id"/>
					</dc:title>
					<mass>
						<xsl:value-of select="*[local-name()='Versions']/*[local-name()='PartVersion']/*[local-name()='Views']/*[local-name()='PartView']/*[local-name()='PropertyValueAssignment']/*[local-name()='AssignedPropertyValues']/*[local-name()='PropertyValue'][./@uid='PRV--26']/*[local-name()='ValueComponent']/*[local-name()='CharacterString']"/>
					</mass>
					<!--VerificationResource relations-->
					<xsl:for-each select=".//*[local-name()='ViewOccurrenceRelationship']/*[local-name()='Related']/@uidRef">
						<SystemComponent.partOf.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.partOf.SystemComponent>
					</xsl:for-each>
					<!--VerificationResource relations-->
					<xsl:for-each select=".//*[local-name()='Occurrence']/@uid">
						<SystemComponent.usedIn.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.usedIn.SystemComponent>
					</xsl:for-each>
				</ver:VerificationResource>
			</xsl:for-each>
			<xsl:for-each select="//(*[local-name()='AoUnitUnderTest']|*[local-name()='AoUnitUnderTestPart'])">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Id']"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='Id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Name']"/>
					</dc:title>
					<dateTime>
						<xsl:value-of select="*[local-name()='DateCreated']"/>
					</dateTime>
					<type>
						<xsl:value-of select="*[local-name()='Classification']"/>
					</type>
					<!--SystemComponent relations-->
					<xsl:for-each select="*[local-name()='ResponsiblePerson']">
						<SystemComponent.ownedBy.Actor>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.ownedBy.Actor>
					</xsl:for-each>
				</sys:SystemComponent>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>