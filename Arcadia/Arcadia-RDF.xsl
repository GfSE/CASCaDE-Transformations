<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns="http://omg.org/spec/CASCaRA/" xmlns:cas="http://omg.org/spec/CASCaRA/Metamodel/" xmlns:arch="http://omg.org/spec/CASCaRA/ProductArchitecture/" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign/" xmlns:org="http://omg.org/spec/CASCaRA/Organization/" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.oa:Entity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--Role-->
				<org:Role>
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
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
				</org:Role>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.oa:Entity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Role relations-->
				<xsl:for-each select="./*/@id">
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
				<xsl:for-each select="//*[local-name()='ownedFunctionalExchanges'][@source='$input']/@target">
					<org:UseCase_ownedBy_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_UseCase.ownedBy.Role_',.)"/>
						</xsl:attribute>
						<org:UseCase_ownedBy_Role_Source>
							<xsl:value-of select="$input"/>
						</org:UseCase_ownedBy_Role_Source>
						<org:UseCase_ownedBy_Role_Target>
							<xsl:value-of select="."/>
						</org:UseCase_ownedBy_Role_Target>
					</org:UseCase_ownedBy_Role>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.fa:FunctionalExchange']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--ComponentConnection-->
				<sys:ComponentConnection>
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
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
				</sys:ComponentConnection>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.fa:FunctionalExchange']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ComponentConnection relations-->
				<xsl:for-each select="substring(@source, 2)">
					<sys:ComponentConnection_connects_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_ComponentConnection.connects.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:ComponentConnection_connects_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</sys:ComponentConnection_connects_SystemComponent_Source>
						<sys:ComponentConnection_connects_SystemComponent_Target>
							<xsl:value-of select="."/>
						</sys:ComponentConnection_connects_SystemComponent_Target>
					</sys:ComponentConnection_connects_SystemComponent>
				</xsl:for-each>
				<!--ComponentConnection relations-->
				<xsl:for-each select="substring(@target, 2)">
					<sys:ComponentConnection_connects_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_ComponentConnection.connects.ComponentInterface_',.)"/>
						</xsl:attribute>
						<sys:ComponentConnection_connects_ComponentInterface_Source>
							<xsl:value-of select="$input"/>
						</sys:ComponentConnection_connects_ComponentInterface_Source>
						<sys:ComponentConnection_connects_ComponentInterface_Target>
							<xsl:value-of select="."/>
						</sys:ComponentConnection_connects_ComponentInterface_Target>
					</sys:ComponentConnection_connects_ComponentInterface>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.fa:FunctionInputPort' or @xsi:type='org.polarsys.capella.core.data.fa:FunctionOutputPort']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--ComponentInterface-->
				<sys:ComponentInterface>
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
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
				</sys:ComponentInterface>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.fa:FunctionInputPort' or @xsi:type='org.polarsys.capella.core.data.fa:FunctionOutputPort']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ComponentInterface relations-->
				<xsl:for-each select="./*/@id">
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
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.la:LogicalFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--Function-->
				<arch:Function>
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
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
				</arch:Function>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.la:LogicalFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Function relations-->
				<xsl:for-each select="./*/@id">
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
				<xsl:for-each select="//*[local-name()='ownedFunctionalExchanges'][@source='$input']/@target">
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
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.oa:OperationalActivity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--UseCase-->
				<arch:UseCase>
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
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
				</arch:UseCase>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.oa:OperationalActivity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--UseCase relations-->
				<xsl:for-each select="./*/@id">
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
				<xsl:for-each select="substring(//*[local-name()='ownedFunctionalExchanges'][@source='#$input']/@target, 2)">
					<arch:UseCase_requires_UseCase>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_UseCase.requires.UseCase_',.)"/>
						</xsl:attribute>
						<arch:UseCase_requires_UseCase_Source>
							<xsl:value-of select="$input"/>
						</arch:UseCase_requires_UseCase_Source>
						<arch:UseCase_requires_UseCase_Target>
							<xsl:value-of select="."/>
						</arch:UseCase_requires_UseCase_Target>
					</arch:UseCase_requires_UseCase>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.pa:PhysicalFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@name"/>
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
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.pa:PhysicalFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--MechanicalComponent relations-->
				<xsl:for-each select="./*/@id">
					<mech:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_partOf_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_partOf_SystemComponent_Source>
						<mech:SystemComponent_partOf_SystemComponent_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_partOf_SystemComponent_Target>
					</mech:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.ctx:SystemFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="@name"/>
				</xsl:variable>
				<!--Function-->
				<arch:Function>
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
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
				</arch:Function>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.ctx:SystemFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Function relations-->
				<xsl:for-each select="./*/@id">
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
				<xsl:for-each select="//*[local-name()='ownedFunctionalExchanges'][@source='$input']/@target">
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
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>