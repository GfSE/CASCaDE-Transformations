<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:csc="http://omg.org/spec/CASCaRA/Metamodel" xmlns:arch="http://omg.org/spec/CASCaRA/ProductArchitecture" xmlns:mech="http://omg.org/spec/CASCaRA/MechanicalDesign" xmlns:org="http://omg.org/spec/CASCaRA/Organization" xmlns:sys="http://omg.org/spec/CASCaRA/SystemsDesign" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:for-each select="//*[@xsi:*[local-name()='type']='org.polarsys.capella.core.data.oa:Entity']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Role-->
				<org:Role>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
					<!--Role relations-->
					<xsl:for-each select="./*/@id">
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
					<xsl:for-each select="//*[local-name()='ownedFunctionalExchanges'][@source=$input]/@target">
						<UseCase.ownedBy.Role>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</UseCase.ownedBy.Role>
					</xsl:for-each>
				</org:Role>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:*[local-name()='type']='org.polarsys.capella.core.data.fa:FunctionalExchange']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ComponentConnection-->
				<sys:ComponentConnection>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
					<!--ComponentConnection relations-->
					<xsl:for-each select="*[local-name()='substring'](@source, 2)">
						<ComponentConnection.connects.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</ComponentConnection.connects.SystemComponent>
					</xsl:for-each>
					<!--ComponentConnection relations-->
					<xsl:for-each select="*[local-name()='substring'](@target, 2)">
						<ComponentConnection.connects.ComponentInterface>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</ComponentConnection.connects.ComponentInterface>
					</xsl:for-each>
				</sys:ComponentConnection>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:*[local-name()='type']='org.polarsys.capella.core.data.fa:FunctionInputPort' or @xsi:*[local-name()='type']='org.polarsys.capella.core.data.fa:FunctionOutputPort']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--ComponentInterface-->
				<sys:ComponentInterface>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
					<!--ComponentInterface relations-->
					<xsl:for-each select="./*/@id">
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
			<xsl:for-each select="//*[@xsi:*[local-name()='type']='org.polarsys.capella.core.data.la:LogicalFunction']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Function-->
				<arch:Function>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
					<!--Function relations-->
					<xsl:for-each select="./*/@id">
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
					<xsl:for-each select="//*[local-name()='ownedFunctionalExchanges'][@source=$input]/@target">
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
			<xsl:for-each select="//*[@xsi:*[local-name()='type']='org.polarsys.capella.core.data.oa:OperationalActivity']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--UseCase-->
				<arch:UseCase>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
					<!--UseCase relations-->
					<xsl:for-each select="./*/@id">
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
					<xsl:for-each select="*[local-name()='substring'](//*[local-name()='ownedFunctionalExchanges'][@source='#$input']/@target, 2)">
						<UseCase.requires.UseCase>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</UseCase.requires.UseCase>
					</xsl:for-each>
				</arch:UseCase>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:*[local-name()='type']='org.polarsys.capella.core.data.pa:PhysicalFunction']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--MechanicalComponent-->
				<mech:MechanicalComponent>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
					<!--MechanicalComponent relations-->
					<xsl:for-each select="./*/@id">
						<SystemComponent.partOf.SystemComponent>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</SystemComponent.partOf.SystemComponent>
					</xsl:for-each>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xsi:*[local-name()='type']='org.polarsys.capella.core.data.ctx:SystemFunction']/ancestor-or-self::*">
				<xsl:variable name="input">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Function-->
				<arch:Function>
					<dc:identifier>
						<xsl:value-of select="@id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@summary"/>
					</dc:description>
					<!--Function relations-->
					<xsl:for-each select="./*/@id">
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
					<xsl:for-each select="//*[local-name()='ownedFunctionalExchanges'][@source=$input]/@target">
						<Function.uses.Function>
							<source>
								<xsl:value-of select="$input"/>
							</source>
							<target>
								<xsl:value-of select="."/>
							</target>
						</Function.uses.Function>
					</xsl:for-each>
				</arch:Function>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>