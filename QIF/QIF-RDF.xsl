<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:ctx="http://www.omg.org/spec/CASCaRA/ontology/ContextElements/" xmlns:mech="http://www.omg.org/spec/CASCaRA/ontology/MechanicalDesign/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<owl:Ontology>
				<xsl:attribute name="rdf:about">
					<xsl:value-of select="concat('http://www.example.org/', generate-id(), '/')"/>
				</xsl:attribute>
				<owl:imports rdf:resource="http://www.omg.org/spec/CASCaRA/ontology/"/>
			</owl:Ontology>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author">
				<xsl:variable name="identifier">
					<xsl:value-of select="*[local-name()='Name']"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(substring-before(./*[local-name()='Name'],' '), ' ', substring-after(./*[local-name()='Name'],' ')))"/>
				</xsl:variable>
				<!--Person-->
				<org:Person>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='Name']"/>
					</dc:identifier>
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
				<!--Person relations-->
				<xsl:for-each select="*[local-name()='Organization']">
					<org:Person_memberOf_OrganizationUnit>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Person.memberOf.OrganizationUnit_',.)"/>
						</xsl:attribute>
						<org:Person_memberOf_OrganizationUnit_Source>
							<xsl:value-of select="$input"/>
						</org:Person_memberOf_OrganizationUnit_Source>
						<org:Person_memberOf_OrganizationUnit_Target>
							<xsl:value-of select="."/>
						</org:Person_memberOf_OrganizationUnit_Target>
					</org:Person_memberOf_OrganizationUnit>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Characteristics']/*[local-name()='CharacteristicDefinitions']/*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space()"/>
				</xsl:variable>
				<!--ModelAnnotation-->
				<mech:ModelAnnotation>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<default:type>
						<xsl:value-of select="name()"/>
					</default:type>
				</mech:ModelAnnotation>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Characteristics']/*[local-name()='CharacteristicDefinitions']/*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='DatumDefinitions']/*[local-name()='DatumDefinition']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(*[local-name()='DatumLabel'])"/>
				</xsl:variable>
				<!--ModelAnnotation-->
				<mech:ModelAnnotation>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='DatumLabel']"/>
					</dc:title>
				</mech:ModelAnnotation>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='DatumDefinitions']/*[local-name()='DatumDefinition']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Features']/*[local-name()='FeatureDefinitions']/*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(@id, ' ', name()))"/>
				</xsl:variable>
				<!--Face-->
				<mech:Face>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
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
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']/*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='ID_NUMBER_MATERIAL']">
				<xsl:variable name="identifier">
					<xsl:value-of select="./*[local-name()='Text']"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(./*[local-name()='Text'], ' ', ../*[local-name()='PartNote'][@label='MATERIAL']/*[local-name()='Text']))"/>
				</xsl:variable>
				<!--Material-->
				<mech:Material>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="./*[local-name()='Text']"/>
					</dc:identifier>
					<default:number>
						<xsl:value-of select="./*[local-name()='Text']"/>
					</default:number>
					<dc:title>
						<xsl:value-of select="../*[local-name()='PartNote'][@label='MATERIAL']/*[local-name()='Text']"/>
					</dc:title>
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
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author/*[local-name()='Organization']">
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
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author/*[local-name()='Organization']">
				<xsl:variable name="identifier">
					<xsl:value-of select="."/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']">
				<xsl:variable name="identifier">
					<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='PART_NAME']/*[local-name()='Text'])"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='PART_NAME']/*[local-name()='Text']"/>
					</dc:title>
					<default:mass>
						<xsl:value-of select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='WEIGHT_CALCULATED']/*[local-name()='Text']"/>
					</default:mass>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']">
				<xsl:variable name="identifier">
					<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
				</xsl:variable>
				<!--MechanicalComponent relations-->
				<xsl:for-each select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='ID_NUMBER_MATERIAL']/*[local-name()='Text']">
					<mech:MechanicalComponent_madeOf_Material>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_MechanicalComponent.madeOf.Material_',.)"/>
						</xsl:attribute>
						<mech:MechanicalComponent_madeOf_Material_Source>
							<xsl:value-of select="$input"/>
						</mech:MechanicalComponent_madeOf_Material_Source>
						<mech:MechanicalComponent_madeOf_Material_Target>
							<xsl:value-of select="."/>
						</mech:MechanicalComponent_madeOf_Material_Target>
					</mech:MechanicalComponent_madeOf_Material>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/StandardsDefinitions/Standard">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(*[local-name()='Organization']/StandardsOrganizationEnum,' ',Designator))"/>
				</xsl:variable>
				<!--Reference-->
				<ctx:Reference>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="concat(*[local-name()='Organization']/StandardsOrganizationEnum,' ',Designator)"/>
					</dc:title>
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