<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:arch="http://www.omg.org/spec/CASCaRA/ontology/ProductArchitecture/" xmlns:mech="http://www.omg.org/spec/CASCaRA/ontology/MechanicalDesign/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" xmlns:sys="http://www.omg.org/spec/CASCaRA/ontology/SystemsDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:variable name="packageUri">
				<xsl:value-of select="concat('http://www.example.org/', generate-id(), '/')"/>
			</xsl:variable>
			<owl:Ontology>
				<xsl:attribute name="rdf:about">
					<xsl:value-of select="$packageUri"/>
				</xsl:attribute>
				<owl:imports rdf:resource="http://www.omg.org/spec/CASCaRA/ontology/"/>
			</owl:Ontology>
			<!--Role-->
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.oa:Entity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<org:Role>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="@summary"/>
					</default:description>
				</org:Role>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.oa:Entity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Role.partOf.Role-->
				<xsl:for-each select="./*/@id">
					<org:Role_partOf_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Role.partOf.Role_',.)"/>
						</xsl:attribute>
						<org:Role_partOf_Role_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</org:Role_partOf_Role_Source>
						<org:Role_partOf_Role_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</org:Role_partOf_Role_Target>
					</org:Role_partOf_Role>
				</xsl:for-each>
				<!--UseCase.ownedBy.Role-->
				<xsl:for-each select="//*[local-name()='ownedFunctionalExchanges'][@source=$identifier]/@target">
					<org:UseCase_ownedBy_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_UseCase.ownedBy.Role_',.)"/>
						</xsl:attribute>
						<org:UseCase_ownedBy_Role_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</org:UseCase_ownedBy_Role_Source>
						<org:UseCase_ownedBy_Role_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</org:UseCase_ownedBy_Role_Target>
					</org:UseCase_ownedBy_Role>
				</xsl:for-each>
			</xsl:for-each>
			<!--ComponentConnection-->
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.fa:FunctionalExchange']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<sys:ComponentConnection>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="@summary"/>
					</default:description>
				</sys:ComponentConnection>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.fa:FunctionalExchange']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ComponentConnection.connects.SystemComponent-->
				<xsl:for-each select="substring(@source, 2)">
					<sys:ComponentConnection_connects_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_ComponentConnection.connects.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:ComponentConnection_connects_SystemComponent_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</sys:ComponentConnection_connects_SystemComponent_Source>
						<sys:ComponentConnection_connects_SystemComponent_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</sys:ComponentConnection_connects_SystemComponent_Target>
					</sys:ComponentConnection_connects_SystemComponent>
				</xsl:for-each>
				<!--ComponentConnection.connects.ComponentInterface-->
				<xsl:for-each select="substring(@target, 2)">
					<sys:ComponentConnection_connects_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_ComponentConnection.connects.ComponentInterface_',.)"/>
						</xsl:attribute>
						<sys:ComponentConnection_connects_ComponentInterface_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</sys:ComponentConnection_connects_ComponentInterface_Source>
						<sys:ComponentConnection_connects_ComponentInterface_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</sys:ComponentConnection_connects_ComponentInterface_Target>
					</sys:ComponentConnection_connects_ComponentInterface>
				</xsl:for-each>
			</xsl:for-each>
			<!--ComponentInterface-->
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.fa:FunctionInputPort' or @xsi:type='org.polarsys.capella.core.data.fa:FunctionOutputPort']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<sys:ComponentInterface>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="@summary"/>
					</default:description>
				</sys:ComponentInterface>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.fa:FunctionInputPort' or @xsi:type='org.polarsys.capella.core.data.fa:FunctionOutputPort']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ComponentInterface.partOf.SystemComponent-->
				<xsl:for-each select="./*/@id">
					<sys:ComponentInterface_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_ComponentInterface.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:ComponentInterface_partOf_SystemComponent_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</sys:ComponentInterface_partOf_SystemComponent_Source>
						<sys:ComponentInterface_partOf_SystemComponent_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</sys:ComponentInterface_partOf_SystemComponent_Target>
					</sys:ComponentInterface_partOf_SystemComponent>
				</xsl:for-each>
			</xsl:for-each>
			<!--Function-->
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.la:LogicalFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<arch:Function>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="@summary"/>
					</default:description>
				</arch:Function>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.la:LogicalFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Function.partOf.Function-->
				<xsl:for-each select="./*/@id">
					<arch:Function_partOf_Function>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Function.partOf.Function_',.)"/>
						</xsl:attribute>
						<arch:Function_partOf_Function_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:Function_partOf_Function_Source>
						<arch:Function_partOf_Function_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</arch:Function_partOf_Function_Target>
					</arch:Function_partOf_Function>
				</xsl:for-each>
				<!--Function.ownedBy.Role-->
				<xsl:for-each select="//*[local-name()='ownedFunctionalExchanges'][@source=$identifier]/@target">
					<arch:Function_ownedBy_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Function.ownedBy.Role_',.)"/>
						</xsl:attribute>
						<arch:Function_ownedBy_Role_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:Function_ownedBy_Role_Source>
						<arch:Function_ownedBy_Role_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</arch:Function_ownedBy_Role_Target>
					</arch:Function_ownedBy_Role>
				</xsl:for-each>
			</xsl:for-each>
			<!--UseCase-->
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.oa:OperationalActivity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<arch:UseCase>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="@summary"/>
					</default:description>
				</arch:UseCase>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.oa:OperationalActivity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--UseCase.partOf.UseCase-->
				<xsl:for-each select="./*/@id">
					<arch:UseCase_partOf_UseCase>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_UseCase.partOf.UseCase_',.)"/>
						</xsl:attribute>
						<arch:UseCase_partOf_UseCase_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:UseCase_partOf_UseCase_Source>
						<arch:UseCase_partOf_UseCase_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</arch:UseCase_partOf_UseCase_Target>
					</arch:UseCase_partOf_UseCase>
				</xsl:for-each>
				<!--UseCase.requires.UseCase-->
				<xsl:for-each select="substring(//*[local-name()='ownedFunctionalExchanges'][@source='#$input']/@target, 2)">
					<arch:UseCase_requires_UseCase>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_UseCase.requires.UseCase_',.)"/>
						</xsl:attribute>
						<arch:UseCase_requires_UseCase_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:UseCase_requires_UseCase_Source>
						<arch:UseCase_requires_UseCase_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</arch:UseCase_requires_UseCase_Target>
					</arch:UseCase_requires_UseCase>
				</xsl:for-each>
			</xsl:for-each>
			<!--MechanicalComponent-->
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.pa:PhysicalFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<mech:MechanicalComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="@summary"/>
					</default:description>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.pa:PhysicalFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--SystemComponent.partOf.SystemComponent-->
				<xsl:for-each select="./*/@id">
					<mech:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_partOf_SystemComponent_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</mech:SystemComponent_partOf_SystemComponent_Source>
						<mech:SystemComponent_partOf_SystemComponent_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</mech:SystemComponent_partOf_SystemComponent_Target>
					</mech:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
			</xsl:for-each>
			<!--Function-->
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.ctx:SystemFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<arch:Function>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="@summary"/>
					</default:description>
				</arch:Function>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.ctx:SystemFunction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Function.partOf.Function-->
				<xsl:for-each select="./*/@id">
					<arch:Function_partOf_Function>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Function.partOf.Function_',.)"/>
						</xsl:attribute>
						<arch:Function_partOf_Function_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:Function_partOf_Function_Source>
						<arch:Function_partOf_Function_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</arch:Function_partOf_Function_Target>
					</arch:Function_partOf_Function>
				</xsl:for-each>
				<!--Function.uses.Function-->
				<xsl:for-each select="//*[local-name()='ownedFunctionalExchanges'][@source=$identifier]/@target">
					<arch:Function_uses_Function>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Function.uses.Function_',.)"/>
						</xsl:attribute>
						<arch:Function_uses_Function_Source>
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</arch:Function_uses_Function_Source>
						<arch:Function_uses_Function_Target>
							<xsl:value-of select="concat($packageUri,.)"/>
						</arch:Function_uses_Function_Target>
					</arch:Function_uses_Function>
				</xsl:for-each>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>