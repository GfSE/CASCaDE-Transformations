<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns="http://www.omg.org/spec/ReqIF/20110401/reqif.xsd" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" version="2">
	<xsl:output method="text" encoding="UTF-8" standalone="yes"/>
	<xsl:template match="/">
		<xsl:text>{
	source: {
		entity </xsl:text>
		<Source>
			<SourceEntities>
				<xsl:for-each select="//*[local-name()='SPEC-OBJECT']">
					<Requirement>
						<dc:identifier>
							<xsl:value-of select="@IDENTIFIER"/>
						</dc:identifier>
						<number>
							<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.ForeignID']/@IDENTIFIER]/@THE-VALUE"/>
						</number>
						<dc:title>
							<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Name' or @LONG-NAME='ReqIF.ChapterName']/@IDENTIFIER]/THE-VALUE"/>
						</dc:title>
						<dc:description>
							<xsl:value-of select="*[local-name()='VALUES']/*[./*[local-name()='DEFINITION']/*[starts-with(local-name(),'ATTRIBUTE-DEFINITION')]=//*[local-name()='SPEC-OBJECT-TYPE']/*[local-name()='SPEC-ATTRIBUTES']/*[@LONG-NAME='ReqIF.Text']/@IDENTIFIER]/THE-VALUE"/>
						</dc:description>
					</Requirement>
				</xsl:for-each>
			</SourceEntities>
			<SourceRelations/>
		</Source>
	</xsl:template>
</xsl:stylesheet>
