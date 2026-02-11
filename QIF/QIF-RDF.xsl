<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:ctx="http://omg.org/spec/CASCaRA/ContextElements" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign" xmlns:org="http://omg.org/spec/CASCaRA/Organization" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author">
				<xsl:variable name="input">
					<xsl:value-of select="*[local-name()='Name']"/>
				</xsl:variable>
				<!--Person-->
				<org:Person>
					<dc:identifier>
						<xsl:value-of select="*[local-name()='Name']"/>
					</dc:identifier>
					<firstname>
						<xsl:value-of select="substring-before(./*[local-name()='Name'],' ')"/>
					</firstname>
					<lastname>
						<xsl:value-of select="*[local-name()='substring-after'](./*[local-name()='Name'],' ')"/>
					</lastname>
					<!--Person relations-->
					<xsl:for-each select="*[local-name()='Organization']">
						<Person.memberOf.OrganizationUnit>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Person.memberOf.OrganizationUnit>
					</xsl:for-each>
				</org:Person>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Characteristics']/*[local-name()='CharacteristicDefinitions']/*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ModelAnnotation-->
				<mech:ModelAnnotation>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<type>
						<xsl:value-of select="name()"/>
					</type>
				</mech:ModelAnnotation>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='DatumDefinitions']/*[local-name()='DatumDefinition']">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ModelAnnotation-->
				<mech:ModelAnnotation>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='DatumLabel']"/>
					</dc:title>
				</mech:ModelAnnotation>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Features']/*[local-name()='FeatureDefinitions']/*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Face-->
				<mech:Face>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<type>
						<xsl:value-of select="name()"/>
					</type>
				</mech:Face>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']/*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='ID_NUMBER_MATERIAL']">
				<xsl:variable name="input">
					<xsl:value-of select="./*[local-name()='Text']"/>
				</xsl:variable>
				<!--Material-->
				<mech:Material>
					<dc:identifier>
						<xsl:value-of select="./*[local-name()='Text']"/>
					</dc:identifier>
					<number>
						<xsl:value-of select="./*[local-name()='Text']"/>
					</number>
					<dc:title>
						<xsl:value-of select="../*[local-name()='PartNote'][@label='MATERIAL']/*[local-name()='Text']"/>
					</dc:title>
					<density>
						<xsl:value-of select="../*[local-name()='PartNote'][@label='MATERIAL_DENSITY']/*[local-name()='Text']"/>
					</density>
				</mech:Material>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Header']/Author/*[local-name()='Organization']">
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
			<xsl:for-each select="/*[local-name()='QIFDocument']/*[local-name()='Product']">
				<xsl:variable name="input">
					<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<dc:identifier>
						<xsl:value-of select="./*[local-name()='Header']/*[local-name()='File']/*[local-name()='Name']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='PART_NAME']/*[local-name()='Text']"/>
					</dc:title>
					<mass>
						<xsl:value-of select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='WEIGHT_CALCULATED']/*[local-name()='Text']"/>
					</mass>
					<!--MechanicalComponent relations-->
					<xsl:for-each select="./*[local-name()='PartNoteSet']/*[local-name()='PartNote'][@label='ID_NUMBER_MATERIAL']/*[local-name()='Text']">
						<MechanicalComponent.madeOf.Material>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</MechanicalComponent.madeOf.Material>
					</xsl:for-each>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='QIFDocument']/StandardsDefinitions/Standard">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Reference-->
				<ctx:Reference>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="*[local-name()='concat'](*[local-name()='Organization']/StandardsOrganizationEnum,' ',Designator)"/>
					</dc:title>
				</ctx:Reference>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>