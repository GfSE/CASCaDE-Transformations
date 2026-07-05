<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://omg.org/spec/CASCaRA/" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel/" xmlns:ctx="http://omg.org/spec/CASCaRA/ContextElements/" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign/" xmlns:org="http://omg.org/spec/CASCaRA/Organization/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Name']"/>
				</xsl:variable>
				<!--Person-->
				<org:Person>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='Name']"/>
					</dc:identifier>
					<firstname xmlns="">
						<xsl:value-of select="substring-before(./*[local-name()='Name'],' ')"/>
					</firstname>
					<lastname xmlns="">
						<xsl:value-of select="substring-after(./*[local-name()='Name'],' ')"/>
					</lastname>
				</org:Person>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author">
				<xsl:variable name="input">
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
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ModelAnnotation-->
				<mech:ModelAnnotation>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<type xmlns="">
						<xsl:value-of select="name()"/>
					</type>
				</mech:ModelAnnotation>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Characteristics']/*[local-name()='CharacteristicDefinitions']/*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='DatumDefinitions']/*[local-name()='DatumDefinition']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ModelAnnotation-->
				<mech:ModelAnnotation>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='DatumLabel']"/>
					</dc:title>
				</mech:ModelAnnotation>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='DatumDefinitions']/*[local-name()='DatumDefinition']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Features']/*[local-name()='FeatureDefinitions']/*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Face-->
				<mech:Face>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<type xmlns="">
						<xsl:value-of select="name()"/>
					</type>
				</mech:Face>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Features']/*[local-name()='FeatureDefinitions']/*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']/*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='ID_NUMBER_MATERIAL']">
				<xsl:variable name="input">
					<xsl:value-of select="./*[local-name()='Text']"/>
				</xsl:variable>
				<!--Material-->
				<mech:Material>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="./*[local-name()='Text']"/>
					</dc:identifier>
					<number xmlns="">
						<xsl:value-of select="./*[local-name()='Text']"/>
					</number>
					<dc:title>
						<xsl:value-of select="../*[local-name()='PartNote'][@label='MATERIAL']/*[local-name()='Text']"/>
					</dc:title>
					<density xmlns="">
						<xsl:value-of select="../*[local-name()='PartNote'][@label='MATERIAL_DENSITY']/*[local-name()='Text']"/>
					</density>
				</mech:Material>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']/*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='ID_NUMBER_MATERIAL']">
				<xsl:variable name="input">
					<xsl:value-of select="./*[local-name()='Text']"/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author/*[local-name()='Organization']">
				<xsl:variable name="input">
					<xsl:value-of select="."/>
				</xsl:variable>
				<!--OrganizationUnit-->
				<org:OrganizationUnit>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="."/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="."/>
					</dc:title>
				</org:OrganizationUnit>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author/*[local-name()='Organization']">
				<xsl:variable name="input">
					<xsl:value-of select="."/>
				</xsl:variable>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']">
				<xsl:variable name="input">
					<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='PART_NAME']/*[local-name()='Text']"/>
					</dc:title>
					<mass xmlns="">
						<xsl:value-of select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='WEIGHT_CALCULATED']/*[local-name()='Text']"/>
					</mass>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']">
				<xsl:variable name="input">
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
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Reference-->
				<ctx:Reference>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="concat(*[local-name()='Organization']/StandardsOrganizationEnum,' ',Designator)"/>
					</dc:title>
				</ctx:Reference>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/StandardsDefinitions/Standard">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>