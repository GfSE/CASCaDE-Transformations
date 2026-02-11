<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:arch="http://omg.org/spec/CASCaRA/ProductArchitecture" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign" xmlns:org="http://omg.org/spec/CASCaRA/Organization" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:AcceptEventAction']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--ComponentState-->
				<sys:ComponentState>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<number>
						<xsl:value-of select="//*[@base_Class='$identifier']/@Id"/>
					</number>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:*[local-name()='type']"/>
					</type>
					<!--ComponentState relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<ComponentState.partOf.ComponentState>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</ComponentState.partOf.ComponentState>
					</xsl:for-each>
				</sys:ComponentState>
			</xsl:for-each>
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
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Class' and @xmi:*[local-name()='id']=//*[local-name()='BBM_MBSE_Profile']:*[local-name()='User']/@base_Class]/ancestor-or-self::*">
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
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Class' and @xmi:*[local-name()='id']=//*[local-name()='sysml']:*[local-name()='Block']/@base_Class]/ancestor-or-self::*">
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
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:UseCase' and starts-with(@name, 'Fehlfunktion')]/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--FunctionFailure-->
				<arch:FunctionFailure>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<number>
						<xsl:value-of select="//*[@base_Class='$identifier']/@Id"/>
					</number>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:*[local-name()='type']"/>
					</type>
					<!--FunctionFailure relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<FunctionFailure.partOf.FunctionFailure>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</FunctionFailure.partOf.FunctionFailure>
					</xsl:for-each>
				</arch:FunctionFailure>
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
					<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:ControlFlow' and *[local-name()='target']='$identifier']/@source">
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
					<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:*[local-name()='idref']='$identifier']/*[local-name()='client']/@xmi:*[local-name()='idref']">
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
					<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:*[local-name()='idref']='$identifier']/*[local-name()='client']/@xmi:*[local-name()='idref']">
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
			<xsl:for-each select="///*[@xmi:*[local-name()='type']='uml:Class' and @xmi:*[local-name()='id']=//*[local-name()='sysml']:*[local-name()='InterfaceBlock']/@base_Class]/ancestor-or-self::*">
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
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<ComponentInterface.partOf.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</ComponentInterface.partOf.SystemComponent>
					</xsl:for-each>
				</sys:ComponentInterface>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:*[local-name()='id']=//*[local-name()='sysml']:*[local-name()='Block']/@base_Class]/*[local-name()='ownedAttribute'][@xmi:*[local-name()='type']='uml:Port']">
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
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<ComponentInterface.partOf.ComponentInterface>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</ComponentInterface.partOf.ComponentInterface>
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
			<xsl:for-each select="//*[contains(name(), 'Requirement')]/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--Requirement-->
				<arch:Requirement>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<number>
						<xsl:value-of select="@id|@Id"/>
					</number>
					<dc:title>
						<xsl:value-of select="//*[@xmi:*[local-name()='id']='$identifier']/@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@text|@Text"/>
					</dc:description>
					<type>
						<xsl:value-of select="//*[@xmi:*[local-name()='id']=//*[@xmi:*[local-name()='id']='$identifier']/@base_Class]/@name"/>
					</type>
					<!--Requirement relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<Requirement.partOf.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Requirement.partOf.Requirement>
					</xsl:for-each>
					<!--Requirement relations-->
					<xsl:for-each select="//*[*[local-name()='client']/@xmi:*[local-name()='idref']='$identifier']/*[local-name()='supplier']/@xmi:*[local-name()='idref']">
						<Requirement.satisfies.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Requirement.satisfies.Requirement>
					</xsl:for-each>
				</arch:Requirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Class' and @xmi:*[local-name()='id']=//*[local-name()='BBM_MBSE_Profile']:*[local-name()='StakeholderRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--StakeholderRequirement-->
				<arch:StakeholderRequirement>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<number>
						<xsl:value-of select="@id|@Id"/>
					</number>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="//*[@xmi:*[local-name()='id']='$identifier']/@Text"/>
					</dc:description>
					<type>
						<xsl:value-of select="//*[@xmi:*[local-name()='id']=//*[@xmi:*[local-name()='id']='$identifier']/@base_Class]/@name"/>
					</type>
					<!--StakeholderRequirement relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<Requirement.partOf.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Requirement.partOf.Requirement>
					</xsl:for-each>
					<!--StakeholderRequirement relations-->
					<xsl:for-each select="//*[*[local-name()='client']/@xmi:*[local-name()='idref']='$identifier']/*[local-name()='supplier']/@xmi:*[local-name()='idref']">
						<Requirement.satisfies.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Requirement.satisfies.Requirement>
					</xsl:for-each>
				</arch:StakeholderRequirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Class' and @xmi:*[local-name()='id']=(//*[local-name()='sysml']:*[local-name()='System']/@base_Class)]/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="*[local-name()='ownedAttribute']/@name"/>
					</type>
					<!--MechanicalComponent relations-->
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
					<!--MechanicalComponent relations-->
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
					<!--MechanicalComponent relations-->
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
					<!--MechanicalComponent relations-->
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
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Class' and (@xmi:*[local-name()='id']=//*[local-name()='sysml']:*[local-name()='functionalRequirement']/@base_Class)]/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--SystemRequirement-->
				<arch:SystemRequirement>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<number>
						<xsl:value-of select="@id|@Id"/>
					</number>
					<dc:title>
						<xsl:value-of select="//*[@xmi:*[local-name()='id']='$identifier']/@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@text|@Text"/>
					</dc:description>
					<type>
						<xsl:value-of select="//*[@xmi:*[local-name()='id']=//*[@xmi:*[local-name()='id']='$identifier']/@base_Class]/@name"/>
					</type>
					<!--SystemRequirement relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<Requirement.partOf.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Requirement.partOf.Requirement>
					</xsl:for-each>
					<!--SystemRequirement relations-->
					<xsl:for-each select="//*[*[local-name()='client']/@xmi:*[local-name()='idref']='$identifier']/*[local-name()='supplier']/@xmi:*[local-name()='idref']">
						<Requirement.satisfies.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Requirement.satisfies.Requirement>
					</xsl:for-each>
				</arch:SystemRequirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Class' and @xmi:*[local-name()='id']=//*[local-name()='BBM_MBSE_Profile']:*[local-name()='SystemRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--SystemRequirement-->
				<arch:SystemRequirement>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<number>
						<xsl:value-of select="@id|@Id"/>
					</number>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="//*[@xmi:*[local-name()='id']='$identifier']/@Text"/>
					</dc:description>
					<type>
						<xsl:value-of select="//*[@xmi:*[local-name()='id']=//*[@xmi:*[local-name()='id']='$identifier']/@base_Class]/@name"/>
					</type>
					<!--SystemRequirement relations-->
					<xsl:for-each select="./*/@xmi:*[local-name()='id']">
						<Requirement.partOf.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Requirement.partOf.Requirement>
					</xsl:for-each>
					<!--SystemRequirement relations-->
					<xsl:for-each select="//*[*[local-name()='client']/@xmi:*[local-name()='idref']='$identifier']/*[local-name()='supplier']/@xmi:*[local-name()='idref']">
						<Requirement.satisfies.Requirement>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Requirement.satisfies.Requirement>
					</xsl:for-each>
				</arch:SystemRequirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:*[local-name()='type']='uml:Class' and @xmi:*[local-name()='id']=//*[local-name()='BBM_MBSE_Profile']:*[local-name()='TechnicalElement']/@base_Class]">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:*[local-name()='id']"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<dc:identifier>
						<xsl:value-of select="@xmi:*[local-name()='id']"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="*[local-name()='ownedAttribute']/@name"/>
					</type>
					<!--MechanicalComponent relations-->
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
					<!--MechanicalComponent relations-->
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
					<!--MechanicalComponent relations-->
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
					<!--MechanicalComponent relations-->
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
				</mech:MechanicalComponent>
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
				</arch:UseCase>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>