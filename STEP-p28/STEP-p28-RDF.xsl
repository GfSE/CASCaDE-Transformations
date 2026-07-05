<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://omg.org/spec/CASCaRA/" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel/" xmlns:arch="http://omg.org/spec/CASCaRA/ProductArchitecture/" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign/" xmlns:org="http://omg.org/spec/CASCaRA/Organization/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[local-name()='Representation'][@xsi:type='bom:Mechanism']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--KinematicMechanism-->
				<mech:KinematicMechanism>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@uid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']"/>
					</dc:title>
				</mech:KinematicMechanism>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Representation'][@xsi:type='bom:Mechanism']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--KinematicMechanism relations-->
				<xsl:for-each select=".">
					<mech:KinematicMechanism_partOf_MechanicalComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_KinematicMechanism.partOf.MechanicalComponent_',.)"/>
						</xsl:attribute>
						<mech:KinematicMechanism_partOf_MechanicalComponent_Source>
							<xsl:value-of select="$input"/>
						</mech:KinematicMechanism_partOf_MechanicalComponent_Source>
						<mech:KinematicMechanism_partOf_MechanicalComponent_Target>
							<xsl:value-of select="."/>
						</mech:KinematicMechanism_partOf_MechanicalComponent_Target>
					</mech:KinematicMechanism_partOf_MechanicalComponent>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Occurrence']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@uid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Id']/@id"/>
					</dc:title>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Occurrence']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Organization']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--OrganizationUnit-->
				<org:OrganizationUnit>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@uid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']"/>
					</dc:title>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Organization']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--OrganizationUnit relations-->
				<xsl:for-each select=".//*[local-name()='OrganizationRelationship'][*[local-name()='RelationType']/*[local-name()='ClassString']='hierarchy']/*[local-name()='Related']/@uidRef">
					<org:OrganizationUnit_partOf_OrganizationUnit>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_OrganizationUnit.partOf.OrganizationUnit_',.)"/>
						</xsl:attribute>
						<org:OrganizationUnit_partOf_OrganizationUnit_Source>
							<xsl:value-of select="$input"/>
						</org:OrganizationUnit_partOf_OrganizationUnit_Source>
						<org:OrganizationUnit_partOf_OrganizationUnit_Target>
							<xsl:value-of select="."/>
						</org:OrganizationUnit_partOf_OrganizationUnit_Target>
					</org:OrganizationUnit_partOf_OrganizationUnit>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Part']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@uid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']|*[local-name()='Id']/*[local-name()='Identifier']/@id"/>
					</dc:title>
					<mass xmlns="">
						<xsl:value-of select="*[local-name()='Versions']/*[local-name()='PartVersion']/*[local-name()='Views']/*[local-name()='PartView']/*[local-name()='PropertyValueAssignment']/*[local-name()='AssignedPropertyValues']/*[local-name()='PropertyValue'][./@uid='PRV--26']/*[local-name()='ValueComponent']/*[local-name()='CharacterString']"/>
					</mass>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Part']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--MechanicalComponent relations-->
				<xsl:for-each select=".//*[local-name()='ViewOccurrenceRelationship']/*[local-name()='Related']/@uidRef">
					<mech:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_partOf_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_partOf_SystemComponent_Source>
						<mech:SystemComponent_partOf_SystemComponent_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_partOf_SystemComponent_Target>
					</mech:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
				<!--MechanicalComponent relations-->
				<xsl:for-each select=".//*[local-name()='Occurrence']/@uid">
					<mech:SystemComponent_usedIn_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.usedIn.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_usedIn_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_usedIn_SystemComponent_Source>
						<mech:SystemComponent_usedIn_SystemComponent_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_usedIn_SystemComponent_Target>
					</mech:SystemComponent_usedIn_SystemComponent>
				</xsl:for-each>
				<!--MechanicalComponent relations-->
				<xsl:for-each select=".//*[local-name()='AssignedRequirement']/@uidRef">
					<mech:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_fulfils_Requirement_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_fulfils_Requirement_Source>
						<mech:SystemComponent_fulfils_Requirement_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_fulfils_Requirement_Target>
					</mech:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
				<!--MechanicalComponent relations-->
				<xsl:for-each select="//*[local-name()='Requirement'][//*[local-name()='RequirementView']/@uid=$input]/*[local-name()='uid']">
					<mech:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_fulfils_Requirement_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_fulfils_Requirement_Source>
						<mech:SystemComponent_fulfils_Requirement_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_fulfils_Requirement_Target>
					</mech:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Project']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--Project-->
				<org:Project>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@uid"/>
					</dc:identifier>
					<number xmlns="">
						<xsl:value-of select="*[local-name()='Id']/@id"/>
					</number>
					<dc:title>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']"/>
					</dc:title>
				</org:Project>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Project']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--Project relations-->
				<xsl:for-each select=".//*[local-name()='ResponsibleOrganizations']/*[local-name()='Organization']/@uidRef">
					<org:Event_ownedBy_Actor>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Event.ownedBy.Actor_',.)"/>
						</xsl:attribute>
						<org:Event_ownedBy_Actor_Source>
							<xsl:value-of select="$input"/>
						</org:Event_ownedBy_Actor_Source>
						<org:Event_ownedBy_Actor_Target>
							<xsl:value-of select="."/>
						</org:Event_ownedBy_Actor_Target>
					</org:Event_ownedBy_Actor>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Requirement']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--Requirement-->
				<arch:Requirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@uid"/>
					</dc:identifier>
					<number xmlns="">
						<xsl:value-of select="*[local-name()='Id']/*[local-name()='Identifier']/@id"/>
					</number>
					<dc:description>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']"/>
					</dc:description>
				</arch:Requirement>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Requirement']">
				<xsl:variable name="input">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>