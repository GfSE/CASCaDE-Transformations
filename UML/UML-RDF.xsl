<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:arch="http://omg.org/spec/CASCaRA/ProductArchitecture" xmlns:org="http://omg.org/spec/CASCaRA/Organization" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Actor']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--Role-->
				<org:Role>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<!--Role relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<Role.partOf.Role>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Role.partOf.Role>
					</xsl:for-each>
					<!--Role relations-->
					<xsl:for-each select="*[local-name()='generalization']/@general">
						<Role.specialismOf.Role>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Role.specialismOf.Role>
					</xsl:for-each>
				</org:Role>
			</xsl:for-each>
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
					<xsl:for-each select="//*[*[local-name()='client']/@xmi:*[local-name()='idref']=$input]/*[local-name()='supplier']/@xmi:*[local-name()='idref']">
						<SystemComponent.fulfils.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.fulfils.Requirement>
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
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Activity']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--Function-->
				<arch:Function>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:*[local-name()='type']"/>
					</type>
					<!--Function relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<Function.partOf.Function>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Function.partOf.Function>
					</xsl:for-each>
					<!--Function relations-->
					<xsl:for-each select="*[local-name()='generalization']/@general">
						<Function.specialismOf.Function>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Function.specialismOf.Function>
					</xsl:for-each>
					<!--Function relations-->
					<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:ControlFlow' and *[local-name()='target']=$input]/@source">
						<Function.follows.Function>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Function.follows.Function>
					</xsl:for-each>
					<!--Function relations-->
					<xsl:for-each select="/*[@xmi:*[local-name()='type']='uml:CallBehaviorAction']/@behavior">
						<Function.uses.Function>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Function.uses.Function>
					</xsl:for-each>
					<!--Function relations-->
					<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:*[local-name()='idref']=$input]/*[local-name()='client']/@xmi:*[local-name()='idref']">
						<Function.ownedBy.UseCase>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Function.ownedBy.UseCase>
					</xsl:for-each>
					<!--Function relations-->
					<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:*[local-name()='idref']=$input]/*[local-name()='client']/@xmi:*[local-name()='idref']">
						<Function.ownedBy.Role>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Function.ownedBy.Role>
					</xsl:for-each>
				</arch:Function>
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
					<xsl:for-each select="//*[*[local-name()='client']/@xmi:*[local-name()='idref']=$input]/*[local-name()='supplier']/@xmi:*[local-name()='idref']">
						<SystemComponent.fulfils.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.fulfils.Requirement>
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
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Port']">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--ComponentInterface-->
				<sys:ComponentInterface>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:*[local-name()='type']"/>
					</type>
					<!--ComponentInterface relations-->
					<xsl:for-each select="../@xmi:*[local-name()='id']">
						<ComponentInterface.partOf.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</ComponentInterface.partOf.SystemComponent>
					</xsl:for-each>
					<!--ComponentInterface relations-->
					<xsl:for-each select="*[local-name()='generalization']/@general">
						<ComponentInterface.specialismOf.ComponentInterface>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</ComponentInterface.specialismOf.ComponentInterface>
					</xsl:for-each>
				</sys:ComponentInterface>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:UseCase']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--UseCase-->
				<arch:UseCase>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:*[local-name()='type']"/>
					</type>
					<!--UseCase relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<UseCase.partOf.UseCase>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</UseCase.partOf.UseCase>
					</xsl:for-each>
					<!--UseCase relations-->
					<xsl:for-each select="*[local-name()='generalization']/@general">
						<UseCase.specialismOf.UseCase>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</UseCase.specialismOf.UseCase>
					</xsl:for-each>
					<!--UseCase relations-->
					<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:*[local-name()='idRef']=$input]/*[local-name()='client']/@xmi:*[local-name()='idRef']">
						<UseCase.ownedBy.Role>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</UseCase.ownedBy.Role>
					</xsl:for-each>
				</arch:UseCase>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>