<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:org.polarsys.capella.core.data.ctx="http://www.polarsys.org/capella/core/ctx/7.0.0" xmlns:org.polarsys.capella.core.data.fa="http://www.polarsys.org/capella/core/fa/7.0.0" xmlns:org.polarsys.capella.core.data.la="http://www.polarsys.org/capella/core/la/7.0.0" xmlns:org.polarsys.capella.core.data.oa="http://www.polarsys.org/capella/core/oa/7.0.0" xmlns:org.polarsys.capella.core.data.pa="http://www.polarsys.org/capella/core/pa/7.0.0" xmlns:arch="http://www.omg.org/spec/CASCaRA/ontology/ProductArchitecture/" xmlns:mech="http://www.omg.org/spec/CASCaRA/ontology/MechanicalDesign/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" xmlns:sys="http://www.omg.org/spec/CASCaRA/ontology/SystemsDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<cas:aPackage>
			<xsl:variable name="packageUri">
				<xsl:value-of select="concat('http://www.example.org/', generate-id(), '/')"/>
			</xsl:variable>
			<xsl:attribute name="id">
				<xsl:value-of select="$packageUri"/>
			</xsl:attribute>
			<dcterms:contributor>Michael Kirsch, :em engineering methods AG</dcterms:contributor>
			<dcterms:license>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
The software is provided 'as is', without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.
https://opensource.org/licenses/MIT</dcterms:license>
			<graph>
				<!--Role-->
				<xsl:for-each select="//*[@xsi:type='org.polarsys.capella.core.data.oa:Entity']/ancestor-or-self::*">
					<xsl:variable name="identifier">
						<xsl:value-of select="@id"/>
					</xsl:variable>
					<xsl:variable name="label">
						<xsl:value-of select="normalize-space(@name)"/>
					</xsl:variable>
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="@name"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="@summary"/>
						</cas:Property>
					</cas:anEntity>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</org:Role_partOf_Role_Source>
							<org:Role_partOf_Role_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</org:UseCase_ownedBy_Role_Source>
							<org:UseCase_ownedBy_Role_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="@name"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="@summary"/>
						</cas:Property>
					</cas:anEntity>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</sys:ComponentConnection_connects_SystemComponent_Source>
							<sys:ComponentConnection_connects_SystemComponent_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</sys:ComponentConnection_connects_ComponentInterface_Source>
							<sys:ComponentConnection_connects_ComponentInterface_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="@name"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="@summary"/>
						</cas:Property>
					</cas:anEntity>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</sys:ComponentInterface_partOf_SystemComponent_Source>
							<sys:ComponentInterface_partOf_SystemComponent_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="@name"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="@summary"/>
						</cas:Property>
					</cas:anEntity>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:Function_partOf_Function_Source>
							<arch:Function_partOf_Function_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:Function_ownedBy_Role_Source>
							<arch:Function_ownedBy_Role_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="@name"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="@summary"/>
						</cas:Property>
					</cas:anEntity>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:UseCase_partOf_UseCase_Source>
							<arch:UseCase_partOf_UseCase_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:UseCase_requires_UseCase_Source>
							<arch:UseCase_requires_UseCase_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="@name"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="@summary"/>
						</cas:Property>
					</cas:anEntity>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</mech:SystemComponent_partOf_SystemComponent_Source>
							<mech:SystemComponent_partOf_SystemComponent_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
					<cas:anEntity>
						<xsl:attribute name="id">
							<xsl:value-of select="concat($packageUri, $identifier)"/>
						</xsl:attribute>
						<xsl:element name="dcterms:title">
							<xsl:value-of select="$label"/>
						</xsl:element>
						<cas:Property cas:hasClass="identifier">
							<xsl:value-of select="@id"/>
						</cas:Property>
						<cas:Property cas:hasClass="title">
							<xsl:value-of select="@name"/>
						</cas:Property>
						<cas:Property cas:hasClass="description">
							<xsl:value-of select="@summary"/>
						</cas:Property>
					</cas:anEntity>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:Function_partOf_Function_Source>
							<arch:Function_partOf_Function_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
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
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri, $identifier)"/>
								</xsl:attribute>
							</arch:Function_uses_Function_Source>
							<arch:Function_uses_Function_Target>
								<xsl:attribute name="rdf:resource">
									<xsl:value-of select="concat($packageUri,.)"/>
								</xsl:attribute>
							</arch:Function_uses_Function_Target>
						</arch:Function_uses_Function>
					</xsl:for-each>
				</xsl:for-each>
			</graph>
		</cas:aPackage>
	</xsl:template>
</xsl:stylesheet>