<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:bom="http://standards.iso.org/iso/ts/10303/-3001/-ed-1/tech/xml-schema/bo_model" xmlns:arch="http://www.omg.org/spec/CASCaRA/ontology/ProductArchitecture/" xmlns:mech="http://www.omg.org/spec/CASCaRA/ontology/MechanicalDesign/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" version="1">
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
			<!--KinematicMechanism-->
			<xsl:for-each select="//*[local-name()='Representation'][@xsi:type='bom:Mechanism']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(*[local-name()='Name']/*[local-name()='CharacterString'])"/>
				</xsl:variable>
				<mech:KinematicMechanism>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@uid"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']"/>
					</default:title>
				</mech:KinematicMechanism>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Representation'][@xsi:type='bom:Mechanism']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--KinematicMechanism.partOf.MechanicalComponent-->
				<xsl:for-each select=".">
					<mech:KinematicMechanism_partOf_MechanicalComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_KinematicMechanism.partOf.MechanicalComponent_',.)"/>
						</xsl:attribute>
						<mech:KinematicMechanism_partOf_MechanicalComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:KinematicMechanism_partOf_MechanicalComponent_Source>
						<mech:KinematicMechanism_partOf_MechanicalComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:KinematicMechanism_partOf_MechanicalComponent_Target>
					</mech:KinematicMechanism_partOf_MechanicalComponent>
				</xsl:for-each>
			</xsl:for-each>
			<!--MechanicalComponent-->
			<xsl:for-each select="//*[local-name()='Occurrence']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(*[local-name()='Id']/@id)"/>
				</xsl:variable>
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@uid"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="*[local-name()='Id']/@id"/>
					</default:title>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Occurrence']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
			</xsl:for-each>
			<!--OrganizationUnit-->
			<xsl:for-each select="//*[local-name()='Organization']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(*[local-name()='Name']/*[local-name()='CharacterString'])"/>
				</xsl:variable>
				<org:OrganizationUnit>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@uid"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']"/>
					</default:title>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Organization']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--OrganizationUnit.partOf.OrganizationUnit-->
				<xsl:for-each select=".//*[local-name()='OrganizationRelationship'][*[local-name()='RelationType']/*[local-name()='ClassString']='hierarchy']/*[local-name()='Related']/@uidRef">
					<org:OrganizationUnit_partOf_OrganizationUnit>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_OrganizationUnit.partOf.OrganizationUnit_',.)"/>
						</xsl:attribute>
						<org:OrganizationUnit_partOf_OrganizationUnit_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</org:OrganizationUnit_partOf_OrganizationUnit_Source>
						<org:OrganizationUnit_partOf_OrganizationUnit_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</org:OrganizationUnit_partOf_OrganizationUnit_Target>
					</org:OrganizationUnit_partOf_OrganizationUnit>
				</xsl:for-each>
			</xsl:for-each>
			<!--MechanicalComponent-->
			<xsl:for-each select="//*[local-name()='Part']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(*[local-name()='Name']/*[local-name()='CharacterString']|*[local-name()='Id']/*[local-name()='Identifier']/@id)"/>
				</xsl:variable>
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@uid"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']|*[local-name()='Id']/*[local-name()='Identifier']/@id"/>
					</default:title>
					<default:mass>
						<xsl:value-of select="*[local-name()='Versions']/*[local-name()='PartVersion']/*[local-name()='Views']/*[local-name()='PartView']/*[local-name()='PropertyValueAssignment']/*[local-name()='AssignedPropertyValues']/*[local-name()='PropertyValue'][./@uid='PRV--26']/*[local-name()='ValueComponent']/*[local-name()='CharacterString']"/>
					</default:mass>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Part']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--SystemComponent.partOf.SystemComponent-->
				<xsl:for-each select=".//*[local-name()='ViewOccurrenceRelationship']/*[local-name()='Related']/@uidRef">
					<mech:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_partOf_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:SystemComponent_partOf_SystemComponent_Source>
						<mech:SystemComponent_partOf_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:SystemComponent_partOf_SystemComponent_Target>
					</mech:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.usedIn.SystemComponent-->
				<xsl:for-each select=".//*[local-name()='Occurrence']/@uid">
					<mech:SystemComponent_usedIn_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.usedIn.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_usedIn_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:SystemComponent_usedIn_SystemComponent_Source>
						<mech:SystemComponent_usedIn_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:SystemComponent_usedIn_SystemComponent_Target>
					</mech:SystemComponent_usedIn_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.fulfils.Requirement-->
				<xsl:for-each select=".//*[local-name()='AssignedRequirement']/@uidRef">
					<mech:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_fulfils_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:SystemComponent_fulfils_Requirement_Source>
						<mech:SystemComponent_fulfils_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:SystemComponent_fulfils_Requirement_Target>
					</mech:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
				<!--SystemComponent.fulfils.Requirement-->
				<xsl:for-each select="//*[local-name()='Requirement'][//*[local-name()='RequirementView']/@uid=$identifier]/*[local-name()='uid']">
					<mech:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_fulfils_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:SystemComponent_fulfils_Requirement_Source>
						<mech:SystemComponent_fulfils_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:SystemComponent_fulfils_Requirement_Target>
					</mech:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<!--Project-->
			<xsl:for-each select="//*[local-name()='Project']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(*[local-name()='Id']/@id, ' ', *[local-name()='Name']/*[local-name()='CharacterString']))"/>
				</xsl:variable>
				<org:Project>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@uid"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="*[local-name()='Id']/@id"/>
					</default:number>
					<default:title>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']"/>
					</default:title>
				</org:Project>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Project']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<!--Event.ownedBy.Actor-->
				<xsl:for-each select=".//*[local-name()='ResponsibleOrganizations']/*[local-name()='Organization']/@uidRef">
					<org:Event_ownedBy_Actor>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Event.ownedBy.Actor_',.)"/>
						</xsl:attribute>
						<org:Event_ownedBy_Actor_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</org:Event_ownedBy_Actor_Source>
						<org:Event_ownedBy_Actor_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</org:Event_ownedBy_Actor_Target>
					</org:Event_ownedBy_Actor>
				</xsl:for-each>
			</xsl:for-each>
			<!--Requirement-->
			<xsl:for-each select="//*[local-name()='Requirement']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(*[local-name()='Id']/*[local-name()='Identifier']/@id)"/>
				</xsl:variable>
				<arch:Requirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@uid"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="*[local-name()='Id']/*[local-name()='Identifier']/@id"/>
					</default:number>
					<default:description>
						<xsl:value-of select="*[local-name()='Name']/*[local-name()='CharacterString']"/>
					</default:description>
				</arch:Requirement>
			</xsl:for-each>
			<xsl:for-each select="//*[local-name()='Requirement']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@uid"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>