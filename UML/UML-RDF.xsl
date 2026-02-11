<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Component']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:*[local-name()='type']"/>
					</type>
					<!--SystemComponent relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<SystemComponent.partOf.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.partOf.SystemComponent>
					</xsl:for-each>
					<!--SystemComponent relations-->
					<xsl:for-each select="*[local-name()='generalization']/@general">
						<SystemComponent.specialismOf.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.specialismOf.SystemComponent>
					</xsl:for-each>
					<!--SystemComponent relations-->
					<xsl:for-each select="//*[*[local-name()='client']/@xmi:*[local-name()='idref']='$identifier']/*[local-name()='supplier']/@xmi:*[local-name()='idref']">
						<SystemComponent.satisfies.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.satisfies.Requirement>
					</xsl:for-each>
					<!--SystemComponent relations-->
					<xsl:for-each select="/*[local-name()='ownedAttribute'][@xmi:*[local-name()='type']='uml:Port']/@xmi:*[local-name()='id']">
						<SystemComponent.provides.ComponentInterface>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.provides.ComponentInterface>
					</xsl:for-each>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Manifestation']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:*[local-name()='type']"/>
					</type>
					<!--SystemComponent relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<SystemComponent.partOf.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.partOf.SystemComponent>
					</xsl:for-each>
					<!--SystemComponent relations-->
					<xsl:for-each select="*[local-name()='generalization']/@general">
						<SystemComponent.specialismOf.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.specialismOf.SystemComponent>
					</xsl:for-each>
					<!--SystemComponent relations-->
					<xsl:for-each select="//*[*[local-name()='client']/@xmi:*[local-name()='idref']='$identifier']/*[local-name()='supplier']/@xmi:*[local-name()='idref']">
						<SystemComponent.satisfies.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.satisfies.Requirement>
					</xsl:for-each>
					<!--SystemComponent relations-->
					<xsl:for-each select="/*[local-name()='ownedAttribute'][@xmi:*[local-name()='type']='uml:Port']/@xmi:*[local-name()='id']">
						<SystemComponent.provides.ComponentInterface>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.provides.ComponentInterface>
					</xsl:for-each>
				</sys:SystemComponent>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>