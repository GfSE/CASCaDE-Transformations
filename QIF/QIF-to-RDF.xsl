<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:ctx="http://www.omg.org/spec/CASCaRA/ontology/ContextElements/" xmlns:mech="http://www.omg.org/spec/CASCaRA/ontology/MechanicalDesign/" xmlns:op="http://www.omg.org/spec/CASCaRA/ontology/Operation/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" xmlns:ver="http://www.omg.org/spec/CASCaRA/ontology/ProductVerification/" version="1">
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
			<!--PhysicalComponent-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='ActualComponentSets']/*[local-name()='ActualComponentSet']/*[local-name()='ActualComponent']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space()"/>
				</xsl:variable>
				<op:PhysicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
				</op:PhysicalComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='ActualComponentSets']/*[local-name()='ActualComponentSet']/*[local-name()='ActualComponent']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<!--Person-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='Name']"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(substring-before(./*[local-name()='Name'],' '), ' ', substring-after(./*[local-name()='Name'],' ')))"/>
				</xsl:variable>
				<org:Person>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="*[local-name()='Name']"/>
					</default:identifier>
					<default:firstname>
						<xsl:value-of select="substring-before(./*[local-name()='Name'],' ')"/>
					</default:firstname>
					<default:lastname>
						<xsl:value-of select="substring-after(./*[local-name()='Name'],' ')"/>
					</default:lastname>
				</org:Person>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='Name']"/>
				</xsl:variable>
				<!--Person.memberOf.OrganizationUnit-->
				<xsl:for-each select="*[local-name()='Organization']">
					<org:Person_memberOf_OrganizationUnit>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Person.memberOf.OrganizationUnit_',.)"/>
						</xsl:attribute>
						<org:Person_memberOf_OrganizationUnit_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</org:Person_memberOf_OrganizationUnit_Source>
						<org:Person_memberOf_OrganizationUnit_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</org:Person_memberOf_OrganizationUnit_Target>
					</org:Person_memberOf_OrganizationUnit>
				</xsl:for-each>
			</xsl:for-each>
			<!--VerificationCharacteristic-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Characteristics']/*[local-name()='CharacteristicDefinitions']/*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space()"/>
				</xsl:variable>
				<ver:VerificationCharacteristic>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:type>
						<xsl:value-of select="name()"/>
					</default:type>
				</ver:VerificationCharacteristic>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Characteristics']/*[local-name()='CharacteristicDefinitions']/*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<!--Datum-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='DatumDefinitions']/*[local-name()='DatumDefinition']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(*[local-name()='DatumLabel'])"/>
				</xsl:variable>
				<mech:Datum>
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
						<xsl:value-of select="*[local-name()='DatumLabel']"/>
					</default:title>
				</mech:Datum>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='DatumDefinitions']/*[local-name()='DatumDefinition']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<!--Face-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Features']/*[local-name()='FeatureDefinitions']/*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(@id, ' ', name()))"/>
				</xsl:variable>
				<mech:Face>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:type>
						<xsl:value-of select="name()"/>
					</default:type>
				</mech:Face>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Features']/*[local-name()='FeatureDefinitions']/*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<!--Material-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']/*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='ID_NUMBER_MATERIAL']">
				<xsl:variable name="identifier">
					<xsl:value-of select="./*[local-name()='Text']"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(./*[local-name()='Text'], ' ', ../*[local-name()='PartNote'][@label='MATERIAL']/*[local-name()='Text']))"/>
				</xsl:variable>
				<mech:Material>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="./*[local-name()='Text']"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="./*[local-name()='Text']"/>
					</default:number>
					<default:title>
						<xsl:value-of select="../*[local-name()='PartNote'][@label='MATERIAL']/*[local-name()='Text']"/>
					</default:title>
					<default:density>
						<xsl:value-of select="../*[local-name()='PartNote'][@label='MATERIAL_DENSITY']/*[local-name()='Text']"/>
					</default:density>
				</mech:Material>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']/*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='ID_NUMBER_MATERIAL']">
				<xsl:variable name="identifier">
					<xsl:value-of select="./*[local-name()='Text']"/>
				</xsl:variable>
			</xsl:for-each>
			<!--VerificationResource-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='MeasurementResources']/*[local-name()='MeasurementDevices']/*[local-name()='MeasurementDevice']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(*[local-name()='Name'])"/>
				</xsl:variable>
				<ver:VerificationResource>
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
						<xsl:value-of select="*[local-name()='Name']"/>
					</default:title>
				</ver:VerificationResource>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='MeasurementResources']/*[local-name()='MeasurementDevices']/*[local-name()='MeasurementDevice']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<!--OrganizationUnit-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='PreInspectionTraceability']/*[local-name()='InspectingOrganization']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='Name']"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(*[local-name()='Name'])"/>
				</xsl:variable>
				<org:OrganizationUnit>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="*[local-name()='Name']"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="*[local-name()='Name']"/>
					</default:title>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='PreInspectionTraceability']/*[local-name()='InspectingOrganization']">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='Name']"/>
				</xsl:variable>
			</xsl:for-each>
			<!--OrganizationUnit-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author/*[local-name()='Organization']|/*[local-name()='QIFDocument']/StandardsDefinitions/Standard/*[local-name()='Organization']/StandardsOrganizationEnum">
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
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author/*[local-name()='Organization']|/*[local-name()='QIFDocument']/StandardsDefinitions/Standard/*[local-name()='Organization']/StandardsOrganizationEnum">
				<xsl:variable name="identifier">
					<xsl:value-of select="."/>
				</xsl:variable>
			</xsl:for-each>
			<!--MechanicalComponent-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='PartSet']/*[local-name()='Part']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(@label, ' ', *[local-name()='ModelNumber']))"/>
				</xsl:variable>
				<mech:MechanicalComponent>
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
						<xsl:value-of select="@label"/>
					</default:title>
					<default:number>
						<xsl:value-of select="*[local-name()='ModelNumber']"/>
					</default:number>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='PartSet']/*[local-name()='Part']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<!--VerificationCharacteristic-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Plan']//*[ends-with(local-name(), 'PlanElement')]">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(*[local-name()='Name'], ' ', *[local-name()='SequenceNumber']))"/>
				</xsl:variable>
				<ver:VerificationCharacteristic>
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
						<xsl:value-of select="*[local-name()='Name']"/>
					</default:title>
					<default:number>
						<xsl:value-of select="*[local-name()='SequenceNumber']"/>
					</default:number>
				</ver:VerificationCharacteristic>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Plan']//*[ends-with(local-name(), 'PlanElement')]">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<!--MechanicalComponent-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']">
				<xsl:variable name="identifier">
					<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='PART_NAME']/*[local-name()='Text'])"/>
				</xsl:variable>
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='PART_NAME']/*[local-name()='Text']"/>
					</default:title>
					<default:mass>
						<xsl:value-of select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='WEIGHT_CALCULATED']/*[local-name()='Text']"/>
					</default:mass>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']">
				<xsl:variable name="identifier">
					<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
				</xsl:variable>
				<!--MechanicalComponent.madeOf.Material-->
				<xsl:for-each select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='ID_NUMBER_MATERIAL']/*[local-name()='Text']">
					<mech:MechanicalComponent_madeOf_Material>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_MechanicalComponent.madeOf.Material_',.)"/>
						</xsl:attribute>
						<mech:MechanicalComponent_madeOf_Material_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:MechanicalComponent_madeOf_Material_Source>
						<mech:MechanicalComponent_madeOf_Material_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:MechanicalComponent_madeOf_Material_Target>
					</mech:MechanicalComponent_madeOf_Material>
				</xsl:for-each>
			</xsl:for-each>
			<!--ModelView-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='ViewSet']/*[local-name()='SavedViewSet']/*[local-name()='SavedView']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@label)"/>
				</xsl:variable>
				<mech:ModelView>
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
						<xsl:value-of select="@label"/>
					</default:title>
				</mech:ModelView>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='ViewSet']/*[local-name()='SavedViewSet']/*[local-name()='SavedView']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ModelAnnotation.shownIn.ModelView-->
				<xsl:for-each select="AnnotationVisibleIds/*[local-name()='Id']">
					<mech:ModelAnnotation_shownIn_ModelView>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_ModelAnnotation.shownIn.ModelView_',.)"/>
						</xsl:attribute>
						<mech:ModelAnnotation_shownIn_ModelView_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:ModelAnnotation_shownIn_ModelView_Source>
						<mech:ModelAnnotation_shownIn_ModelView_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:ModelAnnotation_shownIn_ModelView_Target>
					</mech:ModelAnnotation_shownIn_ModelView>
				</xsl:for-each>
			</xsl:for-each>
			<!--Reference-->
			<xsl:for-each select="/*[local-name()='QIFDocument']/StandardsDefinitions/Standard">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(*[local-name()='Organization']/StandardsOrganizationEnum,' ',Designator))"/>
				</xsl:variable>
				<ctx:Reference>
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
						<xsl:value-of select="concat(*[local-name()='Organization']/StandardsOrganizationEnum,' ',Designator)"/>
					</default:title>
				</ctx:Reference>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/StandardsDefinitions/Standard">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>