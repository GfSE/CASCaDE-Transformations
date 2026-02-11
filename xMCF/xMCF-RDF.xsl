<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="/*[local-name()='xmcf']/*[local-name()='connection_group']/*[local-name()='connected_to']/*[*[local-name()='not'](@pid=*[local-name()='preceding']::*[local-name()='part']/@pid)]">
				<xsl:variable name="input">
					<xsl:value-of select="@pid"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<dc:identifier>
						<xsl:value-of select="@pid"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@pid"/>
					</dc:title>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="/*[local-name()='xmcf']/*[local-name()='connection_group']/*[local-name()='connection_list']/*">
				<xsl:variable name="input">
					<xsl:value-of select="@label"/>
				</xsl:variable>
				<!--JoiningElement-->
				<mech:JoiningElement>
					<dc:identifier>
						<xsl:value-of select="@label"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@label"/>
					</dc:title>
					<!--JoiningElement relations-->
					<xsl:for-each select="../../*[local-name()='connected_to']/*[local-name()='part']/@pid">
						<JoiningElement.joins.MechanicalComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</JoiningElement.joins.MechanicalComponent>
					</xsl:for-each>
				</mech:JoiningElement>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>