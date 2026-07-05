<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel" xmlns:arch="http://omg.org/spec/CASCaRA/ProductArchitecture/" xmlns:org="http://omg.org/spec/CASCaRA/Organization/" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[@xmi:type='uml:Actor']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Role-->
				<org:Role>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
				</org:Role>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Actor']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Role relations-->
				<xsl:for-each select="./*/@xmi:id">
					<org:Role_partOf_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Role.partOf.Role_',.)"/>
						</xsl:attribute>
						<org:Role_partOf_Role_Source>
							<xsl:value-of select="$input"/>
						</org:Role_partOf_Role_Source>
						<org:Role_partOf_Role_Target>
							<xsl:value-of select="."/>
						</org:Role_partOf_Role_Target>
					</org:Role_partOf_Role>
				</xsl:for-each>
				<!--Role relations-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<org:Role_specializes_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Role.specializes.Role_',.)"/>
						</xsl:attribute>
						<org:Role_specializes_Role_Source>
							<xsl:value-of select="$input"/>
						</org:Role_specializes_Role_Source>
						<org:Role_specializes_Role_Target>
							<xsl:value-of select="."/>
						</org:Role_specializes_Role_Target>
					</org:Role_specializes_Role>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Component']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:type"/>
					</type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Component']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent relations-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_partOf_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_partOf_SystemComponent_Source>
						<sys:SystemComponent_partOf_SystemComponent_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_partOf_SystemComponent_Target>
					</sys:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent relations-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<sys:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_specializes_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_specializes_SystemComponent_Source>
						<sys:SystemComponent_specializes_SystemComponent_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_specializes_SystemComponent_Target>
					</sys:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$input]/*[local-name()='supplier']/@xmi:idref">
					<sys:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_fulfils_Requirement_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_fulfils_Requirement_Source>
						<sys:SystemComponent_fulfils_Requirement_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_fulfils_Requirement_Target>
					</sys:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
				<!--SystemComponent relations-->
				<xsl:for-each select="/*[local-name()='ownedAttribute'][@xmi:type='uml:Port']/@xmi:id">
					<sys:SystemComponent_provides_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.provides.ComponentInterface_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_provides_ComponentInterface_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_provides_ComponentInterface_Source>
						<sys:SystemComponent_provides_ComponentInterface_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_provides_ComponentInterface_Target>
					</sys:SystemComponent_provides_ComponentInterface>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Activity']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Function-->
				<arch:Function>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:type"/>
					</type>
				</arch:Function>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Activity']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Function relations-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:Function_partOf_Function>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Function.partOf.Function_',.)"/>
						</xsl:attribute>
						<arch:Function_partOf_Function_Source>
							<xsl:value-of select="$input"/>
						</arch:Function_partOf_Function_Source>
						<arch:Function_partOf_Function_Target>
							<xsl:value-of select="."/>
						</arch:Function_partOf_Function_Target>
					</arch:Function_partOf_Function>
				</xsl:for-each>
				<!--Function relations-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<arch:Function_specializes_Function>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Function.specializes.Function_',.)"/>
						</xsl:attribute>
						<arch:Function_specializes_Function_Source>
							<xsl:value-of select="$input"/>
						</arch:Function_specializes_Function_Source>
						<arch:Function_specializes_Function_Target>
							<xsl:value-of select="."/>
						</arch:Function_specializes_Function_Target>
					</arch:Function_specializes_Function>
				</xsl:for-each>
				<!--Function relations-->
				<xsl:for-each select="//*[@xmi:type='uml:ControlFlow' and *[local-name()='target']=$input]/@source">
					<arch:Function_follows_Function>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Function.follows.Function_',.)"/>
						</xsl:attribute>
						<arch:Function_follows_Function_Source>
							<xsl:value-of select="$input"/>
						</arch:Function_follows_Function_Source>
						<arch:Function_follows_Function_Target>
							<xsl:value-of select="."/>
						</arch:Function_follows_Function_Target>
					</arch:Function_follows_Function>
				</xsl:for-each>
				<!--Function relations-->
				<xsl:for-each select="/*[@xmi:type='uml:CallBehaviorAction']/@behavior">
					<arch:Function_uses_Function>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Function.uses.Function_',.)"/>
						</xsl:attribute>
						<arch:Function_uses_Function_Source>
							<xsl:value-of select="$input"/>
						</arch:Function_uses_Function_Source>
						<arch:Function_uses_Function_Target>
							<xsl:value-of select="."/>
						</arch:Function_uses_Function_Target>
					</arch:Function_uses_Function>
				</xsl:for-each>
				<!--Function relations-->
				<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:idref=$input]/*[local-name()='client']/@xmi:idref">
					<arch:Function_ownedBy_UseCase>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Function.ownedBy.UseCase_',.)"/>
						</xsl:attribute>
						<arch:Function_ownedBy_UseCase_Source>
							<xsl:value-of select="$input"/>
						</arch:Function_ownedBy_UseCase_Source>
						<arch:Function_ownedBy_UseCase_Target>
							<xsl:value-of select="."/>
						</arch:Function_ownedBy_UseCase_Target>
					</arch:Function_ownedBy_UseCase>
				</xsl:for-each>
				<!--Function relations-->
				<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:idref=$input]/*[local-name()='client']/@xmi:idref">
					<arch:Function_ownedBy_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Function.ownedBy.Role_',.)"/>
						</xsl:attribute>
						<arch:Function_ownedBy_Role_Source>
							<xsl:value-of select="$input"/>
						</arch:Function_ownedBy_Role_Source>
						<arch:Function_ownedBy_Role_Target>
							<xsl:value-of select="."/>
						</arch:Function_ownedBy_Role_Target>
					</arch:Function_ownedBy_Role>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Manifestation']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:type"/>
					</type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Manifestation']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent relations-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_partOf_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_partOf_SystemComponent_Source>
						<sys:SystemComponent_partOf_SystemComponent_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_partOf_SystemComponent_Target>
					</sys:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent relations-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<sys:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_specializes_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_specializes_SystemComponent_Source>
						<sys:SystemComponent_specializes_SystemComponent_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_specializes_SystemComponent_Target>
					</sys:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$input]/*[local-name()='supplier']/@xmi:idref">
					<sys:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_fulfils_Requirement_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_fulfils_Requirement_Source>
						<sys:SystemComponent_fulfils_Requirement_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_fulfils_Requirement_Target>
					</sys:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
				<!--SystemComponent relations-->
				<xsl:for-each select="/*[local-name()='ownedAttribute'][@xmi:type='uml:Port']/@xmi:id">
					<sys:SystemComponent_provides_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.provides.ComponentInterface_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_provides_ComponentInterface_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_provides_ComponentInterface_Source>
						<sys:SystemComponent_provides_ComponentInterface_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_provides_ComponentInterface_Target>
					</sys:SystemComponent_provides_ComponentInterface>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Port']">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--ComponentInterface-->
				<sys:ComponentInterface>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:type"/>
					</type>
					<parent>
						<xsl:value-of select="../@name"/>
					</parent>
				</sys:ComponentInterface>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Port']">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--ComponentInterface relations-->
				<xsl:for-each select="../@xmi:id">
					<sys:ComponentInterface_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_ComponentInterface.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:ComponentInterface_partOf_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</sys:ComponentInterface_partOf_SystemComponent_Source>
						<sys:ComponentInterface_partOf_SystemComponent_Target>
							<xsl:value-of select="."/>
						</sys:ComponentInterface_partOf_SystemComponent_Target>
					</sys:ComponentInterface_partOf_SystemComponent>
				</xsl:for-each>
				<!--ComponentInterface relations-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<sys:ComponentInterface_specializes_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_ComponentInterface.specializes.ComponentInterface_',.)"/>
						</xsl:attribute>
						<sys:ComponentInterface_specializes_ComponentInterface_Source>
							<xsl:value-of select="$input"/>
						</sys:ComponentInterface_specializes_ComponentInterface_Source>
						<sys:ComponentInterface_specializes_ComponentInterface_Target>
							<xsl:value-of select="."/>
						</sys:ComponentInterface_specializes_ComponentInterface_Target>
					</sys:ComponentInterface_specializes_ComponentInterface>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:UseCase']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--UseCase-->
				<arch:UseCase>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$input"/>
					</xsl:attribute>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<type>
						<xsl:value-of select="@xmi:type"/>
					</type>
				</arch:UseCase>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:UseCase']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--UseCase relations-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:UseCase_partOf_UseCase>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_UseCase.partOf.UseCase_',.)"/>
						</xsl:attribute>
						<arch:UseCase_partOf_UseCase_Source>
							<xsl:value-of select="$input"/>
						</arch:UseCase_partOf_UseCase_Source>
						<arch:UseCase_partOf_UseCase_Target>
							<xsl:value-of select="."/>
						</arch:UseCase_partOf_UseCase_Target>
					</arch:UseCase_partOf_UseCase>
				</xsl:for-each>
				<!--UseCase relations-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<arch:UseCase_specializes_UseCase>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_UseCase.specializes.UseCase_',.)"/>
						</xsl:attribute>
						<arch:UseCase_specializes_UseCase_Source>
							<xsl:value-of select="$input"/>
						</arch:UseCase_specializes_UseCase_Source>
						<arch:UseCase_specializes_UseCase_Target>
							<xsl:value-of select="."/>
						</arch:UseCase_specializes_UseCase_Target>
					</arch:UseCase_specializes_UseCase>
				</xsl:for-each>
				<!--UseCase relations-->
				<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:idRef=$input]/*[local-name()='client']/@xmi:idRef">
					<arch:UseCase_ownedBy_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_UseCase.ownedBy.Role_',.)"/>
						</xsl:attribute>
						<arch:UseCase_ownedBy_Role_Source>
							<xsl:value-of select="$input"/>
						</arch:UseCase_ownedBy_Role_Source>
						<arch:UseCase_ownedBy_Role_Target>
							<xsl:value-of select="."/>
						</arch:UseCase_ownedBy_Role_Target>
					</arch:UseCase_ownedBy_Role>
				</xsl:for-each>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>