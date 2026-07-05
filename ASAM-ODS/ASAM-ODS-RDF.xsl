<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign/" xmlns:ver="http://omg.org/spec/CASCaRA/ProductVerification/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//(*[local-name()='AoTest']|*[local-name()='AoSubTest']|*[local-name()='AoTestAbstract'])">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Id']"/>
				</xsl:variable>
				<!--VerificationRun-->
				<ver:VerificationRun>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
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
				</ver:VerificationRun>
			</xsl:for-each>
			<xsl:for-each select="//(*[local-name()='AoTest']|*[local-name()='AoSubTest']|*[local-name()='AoTestAbstract'])">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Id']"/>
				</xsl:variable>
				<!--VerificationRun relations-->
				<xsl:for-each select="*[local-name()='ResponsiblePerson']">
					<ver:VerificationRun_ownedBy_Actor>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_VerificationRun.ownedBy.Actor_',.)"/>
						</xsl:attribute>
						<ver:VerificationRun_ownedBy_Actor_Source>
							<xsl:value-of select="$input"/>
						</ver:VerificationRun_ownedBy_Actor_Source>
						<ver:VerificationRun_ownedBy_Actor_Target>
							<xsl:value-of select="."/>
						</ver:VerificationRun_ownedBy_Actor_Target>
					</ver:VerificationRun_ownedBy_Actor>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[contains(name(),'TestEquipment')]">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Id']"/>
				</xsl:variable>
				<!--VerificationResource-->
				<ver:VerificationResource>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
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
				</ver:VerificationResource>
			</xsl:for-each>
			<xsl:for-each select="//*[contains(name(),'TestEquipment')]">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Id']"/>
				</xsl:variable>
				<!--VerificationResource relations-->
				<xsl:for-each select="*[local-name()='ResponsiblePerson']">
					<ver:SystemComponent_ownedBy_Actor>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.ownedBy.Actor_',.)"/>
						</xsl:attribute>
						<ver:SystemComponent_ownedBy_Actor_Source>
							<xsl:value-of select="$input"/>
						</ver:SystemComponent_ownedBy_Actor_Source>
						<ver:SystemComponent_ownedBy_Actor_Target>
							<xsl:value-of select="."/>
						</ver:SystemComponent_ownedBy_Actor_Target>
					</ver:SystemComponent_ownedBy_Actor>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='TestEquipmentPart']">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='application_attribute'][name='Id']@uid"/>
				</xsl:variable>
				<!--VerificationResource-->
				<ver:VerificationResource>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='application_attribute'][name='Id']@uid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Id']/*[local-name()='Identifier']/@id"/>
					</dc:title>
					<mass>
						<xsl:value-of select="*[local-name()='Versions']/*[local-name()='PartVersion']/*[local-name()='Views']/*[local-name()='PartView']/*[local-name()='PropertyValueAssignment']/*[local-name()='AssignedPropertyValues']/*[local-name()='PropertyValue'][./@uid='PRV--26']/*[local-name()='ValueComponent']/*[local-name()='CharacterString']"/>
					</mass>
				</ver:VerificationResource>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='TestEquipmentPart']">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='application_attribute'][name='Id']@uid"/>
				</xsl:variable>
				<!--VerificationResource relations-->
				<xsl:for-each select=".//*[local-name()='ViewOccurrenceRelationship']/*[local-name()='Related']/@uidRef">
					<ver:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<ver:SystemComponent_partOf_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</ver:SystemComponent_partOf_SystemComponent_Source>
						<ver:SystemComponent_partOf_SystemComponent_Target>
							<xsl:value-of select="."/>
						</ver:SystemComponent_partOf_SystemComponent_Target>
					</ver:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
				<!--VerificationResource relations-->
				<xsl:for-each select=".//*[local-name()='Occurrence']/@uid">
					<ver:SystemComponent_usedIn_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.usedIn.SystemComponent_',.)"/>
						</xsl:attribute>
						<ver:SystemComponent_usedIn_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</ver:SystemComponent_usedIn_SystemComponent_Source>
						<ver:SystemComponent_usedIn_SystemComponent_Target>
							<xsl:value-of select="."/>
						</ver:SystemComponent_usedIn_SystemComponent_Target>
					</ver:SystemComponent_usedIn_SystemComponent>
				</xsl:for-each>
				<!--VerificationResource relations-->
				<xsl:for-each select=".//*[local-name()='AssignedRequirement']/@uidRef">
					<ver:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<ver:SystemComponent_fulfils_Requirement_Source>
							<xsl:value-of select="$input"/>
						</ver:SystemComponent_fulfils_Requirement_Source>
						<ver:SystemComponent_fulfils_Requirement_Target>
							<xsl:value-of select="."/>
						</ver:SystemComponent_fulfils_Requirement_Target>
					</ver:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
				<!--VerificationResource relations-->
				<xsl:for-each select="//*[local-name()='Requirement'][//*[local-name()='RequirementView']/@uid=$input]/*[local-name()='uid']">
					<ver:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<ver:SystemComponent_fulfils_Requirement_Source>
							<xsl:value-of select="$input"/>
						</ver:SystemComponent_fulfils_Requirement_Source>
						<ver:SystemComponent_fulfils_Requirement_Target>
							<xsl:value-of select="."/>
						</ver:SystemComponent_fulfils_Requirement_Target>
					</ver:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//(*[local-name()='AoUnitUnderTest']|*[local-name()='AoUnitUnderTestPart'])">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Id']"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
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
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//(*[local-name()='AoUnitUnderTest']|*[local-name()='AoUnitUnderTestPart'])">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Id']"/>
				</xsl:variable>
				<!--SystemComponent relations-->
				<xsl:for-each select="*[local-name()='ResponsiblePerson']">
					<sys:SystemComponent_ownedBy_Actor>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.ownedBy.Actor_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_ownedBy_Actor_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_ownedBy_Actor_Source>
						<sys:SystemComponent_ownedBy_Actor_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_ownedBy_Actor_Target>
					</sys:SystemComponent_ownedBy_Actor>
				</xsl:for-each>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>