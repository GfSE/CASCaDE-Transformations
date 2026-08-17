<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:sysml="http://www.omg.org/spec/SysML/20181001/SysML" xmlns:uml="http://www.omg.org/spec/UML/20131001" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:arch="http://www.omg.org/spec/CASCaRA/ontology/ProductArchitecture/" xmlns:mech="http://www.omg.org/spec/CASCaRA/ontology/MechanicalDesign/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" xmlns:sys="http://www.omg.org/spec/CASCaRA/ontology/SystemsDesign/" version="1">
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
				<dcterms:contributor>Michael Kirsch, :em engineering methods AG</dcterms:contributor>
				<dcterms:license>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
The software is provided 'as is', without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.
https://opensource.org/licenses/MIT</dcterms:license>
				<owl:imports rdf:resource="http://www.omg.org/spec/CASCaRA/ontology/"/>
			</owl:Ontology>
			<!--ComponentState-->
			<xsl:for-each select="//*[@xmi:type='uml:AcceptEventAction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(//*[@base_Class='$input']/@Id, ' ', @name))"/>
				</xsl:variable>
				<sys:ComponentState>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="//*[@base_Class='$input']/@Id"/>
					</default:number>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:ComponentState>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:AcceptEventAction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--ComponentState.partOf.ComponentState-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:ComponentState_partOf_ComponentState>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_ComponentState.partOf.ComponentState_',.)"/>
						</xsl:attribute>
						<sys:ComponentState_partOf_ComponentState_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:ComponentState_partOf_ComponentState_Source>
						<sys:ComponentState_partOf_ComponentState_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:ComponentState_partOf_ComponentState_Target>
					</sys:ComponentState_partOf_ComponentState>
				</xsl:for-each>
			</xsl:for-each>
			<!--Role-->
			<xsl:for-each select="//*[@xmi:type='uml:Actor']/ancestor-or-self::*">
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
				</org:Role>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Actor']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<!--Role.partOf.Role-->
				<xsl:for-each select="./*/@xmi:id">
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
				<!--Role.specializes.Role-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<org:Role_specializes_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Role.specializes.Role_',.)"/>
						</xsl:attribute>
						<org:Role_specializes_Role_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</org:Role_specializes_Role_Source>
						<org:Role_specializes_Role_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</org:Role_specializes_Role_Target>
					</org:Role_specializes_Role>
				</xsl:for-each>
			</xsl:for-each>
			<!--Role-->
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='User']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
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
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
				</org:Role>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='User']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Role.partOf.Role-->
				<xsl:for-each select="./*/@xmi:id">
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
				<!--Role.specializes.Role-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<org:Role_specializes_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Role.specializes.Role_',.)"/>
						</xsl:attribute>
						<org:Role_specializes_Role_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</org:Role_specializes_Role_Source>
						<org:Role_specializes_Role_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</org:Role_specializes_Role_Target>
					</org:Role_specializes_Role>
				</xsl:for-each>
			</xsl:for-each>
			<!--SystemComponent-->
			<xsl:for-each select="//*[@xmi:type='uml:Class' and (@xmi:id=//*[local-name()='Block']/@base_Class or @xmi:id=//*[local-name()='element'][*[local-name()='properties']/@stereotype='Logical block']/@xmi:idref)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and (@xmi:id=//*[local-name()='Block']/@base_Class or @xmi:id=//*[local-name()='element'][*[local-name()='properties']/@stereotype='Logical block']/@xmi:idref)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent.partOf.SystemComponent-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_partOf_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_partOf_SystemComponent_Source>
						<sys:SystemComponent_partOf_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_partOf_SystemComponent_Target>
					</sys:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.specializes.SystemComponent-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<sys:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_specializes_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_specializes_SystemComponent_Source>
						<sys:SystemComponent_specializes_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_specializes_SystemComponent_Target>
					</sys:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.usedIn.SystemComponent-->
				<xsl:for-each select="./*[local-name()='type']/@xmi:idref">
					<sys:SystemComponent_usedIn_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.usedIn.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_usedIn_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_usedIn_SystemComponent_Source>
						<sys:SystemComponent_usedIn_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_usedIn_SystemComponent_Target>
					</sys:SystemComponent_usedIn_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.fulfils.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<sys:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_fulfils_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_fulfils_Requirement_Source>
						<sys:SystemComponent_fulfils_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_fulfils_Requirement_Target>
					</sys:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<!--SystemComponent-->
			<xsl:for-each select="//*[@xmi:type='uml:Property' and local-name()!='ownedEnd' and (./*[local-name()='type']/@xmi:idref=//*[local-name()='Block']/@base_Class or ./*[local-name()='type']/@xmi:idref=//*[local-name()='element'][*[local-name()='properties']/@stereotype='Logical block']/@xmi:idref)]">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Property' and local-name()!='ownedEnd' and (./*[local-name()='type']/@xmi:idref=//*[local-name()='Block']/@base_Class or ./*[local-name()='type']/@xmi:idref=//*[local-name()='element'][*[local-name()='properties']/@stereotype='Logical block']/@xmi:idref)]">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent.partOf.SystemComponent-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_partOf_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_partOf_SystemComponent_Source>
						<sys:SystemComponent_partOf_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_partOf_SystemComponent_Target>
					</sys:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.specializes.SystemComponent-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<sys:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_specializes_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_specializes_SystemComponent_Source>
						<sys:SystemComponent_specializes_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_specializes_SystemComponent_Target>
					</sys:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.usedIn.SystemComponent-->
				<xsl:for-each select="./*[local-name()='type']/@xmi:idref">
					<sys:SystemComponent_usedIn_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.usedIn.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_usedIn_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_usedIn_SystemComponent_Source>
						<sys:SystemComponent_usedIn_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_usedIn_SystemComponent_Target>
					</sys:SystemComponent_usedIn_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.fulfils.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<sys:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_fulfils_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_fulfils_Requirement_Source>
						<sys:SystemComponent_fulfils_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_fulfils_Requirement_Target>
					</sys:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<!--SystemComponent-->
			<xsl:for-each select="//*[@xmi:type='uml:Component']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Component']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent.partOf.SystemComponent-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_partOf_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_partOf_SystemComponent_Source>
						<sys:SystemComponent_partOf_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_partOf_SystemComponent_Target>
					</sys:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.specializes.SystemComponent-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<sys:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_specializes_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_specializes_SystemComponent_Source>
						<sys:SystemComponent_specializes_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_specializes_SystemComponent_Target>
					</sys:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.fulfils.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<sys:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_fulfils_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_fulfils_Requirement_Source>
						<sys:SystemComponent_fulfils_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_fulfils_Requirement_Target>
					</sys:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
				<!--SystemComponent.provides.ComponentInterface-->
				<xsl:for-each select="/*[local-name()='ownedAttribute'][@xmi:type='uml:Port']/@xmi:id">
					<sys:SystemComponent_provides_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.provides.ComponentInterface_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_provides_ComponentInterface_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_provides_ComponentInterface_Source>
						<sys:SystemComponent_provides_ComponentInterface_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_provides_ComponentInterface_Target>
					</sys:SystemComponent_provides_ComponentInterface>
				</xsl:for-each>
			</xsl:for-each>
			<!--Deviation-->
			<xsl:for-each select="//*[@xmi:type='uml:UseCase' and starts-with(@name, 'Fehlfunktion')]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(//*[@base_Class='$input']/@Id, ' ', @name))"/>
				</xsl:variable>
				<sys:Deviation>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="//*[@base_Class='$input']/@Id"/>
					</default:number>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:Deviation>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:UseCase' and starts-with(@name, 'Fehlfunktion')]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Deviation.partOf.Deviation-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:Deviation_partOf_Deviation>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Deviation.partOf.Deviation_',.)"/>
						</xsl:attribute>
						<sys:Deviation_partOf_Deviation_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:Deviation_partOf_Deviation_Source>
						<sys:Deviation_partOf_Deviation_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:Deviation_partOf_Deviation_Target>
					</sys:Deviation_partOf_Deviation>
				</xsl:for-each>
			</xsl:for-each>
			<!--Function-->
			<xsl:for-each select="//*[@xmi:type='uml:Activity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
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
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</arch:Function>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Activity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Function.partOf.Function-->
				<xsl:for-each select="./*/@xmi:id">
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
				<!--Function.specializes.Function-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<arch:Function_specializes_Function>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Function.specializes.Function_',.)"/>
						</xsl:attribute>
						<arch:Function_specializes_Function_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Function_specializes_Function_Source>
						<arch:Function_specializes_Function_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Function_specializes_Function_Target>
					</arch:Function_specializes_Function>
				</xsl:for-each>
				<!--Function.follows.Function-->
				<xsl:for-each select="//*[@xmi:type='uml:ControlFlow' and *[local-name()='target']=$identifier]/@source">
					<arch:Function_follows_Function>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Function.follows.Function_',.)"/>
						</xsl:attribute>
						<arch:Function_follows_Function_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Function_follows_Function_Source>
						<arch:Function_follows_Function_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Function_follows_Function_Target>
					</arch:Function_follows_Function>
				</xsl:for-each>
				<!--Function.uses.Function-->
				<xsl:for-each select="/*[@xmi:type='uml:CallBehaviorAction']/@behavior">
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
				<!--Function.ownedBy.UseCase-->
				<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:idref=$identifier]/*[local-name()='client']/@xmi:idref">
					<arch:Function_ownedBy_UseCase>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Function.ownedBy.UseCase_',.)"/>
						</xsl:attribute>
						<arch:Function_ownedBy_UseCase_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Function_ownedBy_UseCase_Source>
						<arch:Function_ownedBy_UseCase_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Function_ownedBy_UseCase_Target>
					</arch:Function_ownedBy_UseCase>
				</xsl:for-each>
				<!--Function.ownedBy.Role-->
				<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:idref=$identifier]/*[local-name()='client']/@xmi:idref">
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
			<!--ComponentInterface-->
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='InterfaceBlock']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
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
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:ComponentInterface>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='InterfaceBlock']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--ComponentInterface.partOf.SystemComponent-->
				<xsl:for-each select="../@xmi:id">
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
			<!--SystemComponent-->
			<xsl:for-each select="//*[@xmi:type='uml:Manifestation']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Manifestation']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent.partOf.SystemComponent-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:SystemComponent_partOf_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.partOf.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_partOf_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_partOf_SystemComponent_Source>
						<sys:SystemComponent_partOf_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_partOf_SystemComponent_Target>
					</sys:SystemComponent_partOf_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.specializes.SystemComponent-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<sys:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_specializes_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_specializes_SystemComponent_Source>
						<sys:SystemComponent_specializes_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_specializes_SystemComponent_Target>
					</sys:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.fulfils.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<sys:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_fulfils_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_fulfils_Requirement_Source>
						<sys:SystemComponent_fulfils_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_fulfils_Requirement_Target>
					</sys:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
				<!--SystemComponent.provides.ComponentInterface-->
				<xsl:for-each select="/*[local-name()='ownedAttribute'][@xmi:type='uml:Port']/@xmi:id">
					<sys:SystemComponent_provides_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.provides.ComponentInterface_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_provides_ComponentInterface_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:SystemComponent_provides_ComponentInterface_Source>
						<sys:SystemComponent_provides_ComponentInterface_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:SystemComponent_provides_ComponentInterface_Target>
					</sys:SystemComponent_provides_ComponentInterface>
				</xsl:for-each>
			</xsl:for-each>
			<!--ComponentInterface-->
			<xsl:for-each select="//*[@xmi:type='uml:Port']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
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
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
					<default:parent>
						<xsl:value-of select="../@name"/>
					</default:parent>
				</sys:ComponentInterface>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Port']">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--ComponentInterface.partOf.SystemComponent-->
				<xsl:for-each select="../@xmi:id">
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
				<!--ComponentInterface.specializes.ComponentInterface-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<sys:ComponentInterface_specializes_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_ComponentInterface.specializes.ComponentInterface_',.)"/>
						</xsl:attribute>
						<sys:ComponentInterface_specializes_ComponentInterface_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</sys:ComponentInterface_specializes_ComponentInterface_Source>
						<sys:ComponentInterface_specializes_ComponentInterface_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</sys:ComponentInterface_specializes_ComponentInterface_Target>
					</sys:ComponentInterface_specializes_ComponentInterface>
				</xsl:for-each>
			</xsl:for-each>
			<!--Requirement-->
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='Requirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(//*[local-name()='Requirement'][@base_Class='$identifier']/@*[name()='id' or name()='Id'], ' ', @name))"/>
				</xsl:variable>
				<arch:Requirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="//*[local-name()='Requirement'][@base_Class='$identifier']/@*[name()='id' or name()='Id']"/>
					</default:number>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="//*[local-name()='Requirement'][@base_Class='$identifier']/@*[name()='text' or name()='Text']"/>
					</default:description>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</arch:Requirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='Requirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Requirement.partOf.Requirement-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:Requirement_partOf_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.partOf.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_partOf_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Requirement_partOf_Requirement_Target>
					</arch:Requirement_partOf_Requirement>
				</xsl:for-each>
				<!--Requirement.satisfies.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<arch:Requirement_satisfies_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.satisfies.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_satisfies_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Requirement_satisfies_Requirement_Source>
						<arch:Requirement_satisfies_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Requirement_satisfies_Requirement_Target>
					</arch:Requirement_satisfies_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<!--StakeholderRequirement-->
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='StakeholderRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(@id|@Id, ' ', @name))"/>
				</xsl:variable>
				<arch:StakeholderRequirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="@id|@Id"/>
					</default:number>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="//*[@xmi:id='$input']/@Text"/>
					</default:description>
					<default:type>
						<xsl:value-of select="//*[@xmi:id=//*[@xmi:id='$input']/@base_Class]/@name"/>
					</default:type>
				</arch:StakeholderRequirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='StakeholderRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Requirement.partOf.Requirement-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:Requirement_partOf_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.partOf.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_partOf_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Requirement_partOf_Requirement_Target>
					</arch:Requirement_partOf_Requirement>
				</xsl:for-each>
				<!--Requirement.satisfies.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<arch:Requirement_satisfies_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.satisfies.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_satisfies_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Requirement_satisfies_Requirement_Source>
						<arch:Requirement_satisfies_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Requirement_satisfies_Requirement_Target>
					</arch:Requirement_satisfies_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<!--MechanicalComponent-->
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='System']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
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
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="*[local-name()='ownedAttribute']/@name"/>
					</default:type>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='System']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent.partOf.SystemComponent-->
				<xsl:for-each select="./*/@xmi:id">
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
				<!--SystemComponent.specializes.SystemComponent-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<mech:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_specializes_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:SystemComponent_specializes_SystemComponent_Source>
						<mech:SystemComponent_specializes_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:SystemComponent_specializes_SystemComponent_Target>
					</mech:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.fulfils.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<mech:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_fulfils_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:SystemComponent_fulfils_Requirement_Source>
						<mech:SystemComponent_fulfils_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:SystemComponent_fulfils_Requirement_Target>
					</mech:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<!--SystemRequirement-->
			<xsl:for-each select="//*[@xmi:type='uml:Class' and (@xmi:id=//*[local-name()='functionalRequirement']/@base_Class)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(@id|@Id, ' ', //*[@xmi:id='$input']/@name))"/>
				</xsl:variable>
				<arch:SystemRequirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="@id|@Id"/>
					</default:number>
					<default:title>
						<xsl:value-of select="//*[@xmi:id='$input']/@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="@text|@Text"/>
					</default:description>
					<default:type>
						<xsl:value-of select="//*[@xmi:id=//*[@xmi:id='$input']/@base_Class]/@name"/>
					</default:type>
				</arch:SystemRequirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and (@xmi:id=//*[local-name()='functionalRequirement']/@base_Class)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Requirement.partOf.Requirement-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:Requirement_partOf_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.partOf.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_partOf_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Requirement_partOf_Requirement_Target>
					</arch:Requirement_partOf_Requirement>
				</xsl:for-each>
				<!--Requirement.satisfies.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<arch:Requirement_satisfies_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.satisfies.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_satisfies_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Requirement_satisfies_Requirement_Source>
						<arch:Requirement_satisfies_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Requirement_satisfies_Requirement_Target>
					</arch:Requirement_satisfies_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<!--SystemRequirement-->
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='SystemRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(@id|@Id, ' ', @name))"/>
				</xsl:variable>
				<arch:SystemRequirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="concat($packageUri, $identifier)"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<default:identifier>
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:number>
						<xsl:value-of select="@id|@Id"/>
					</default:number>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:description>
						<xsl:value-of select="//*[@xmi:id='$input']/@Text"/>
					</default:description>
					<default:type>
						<xsl:value-of select="//*[@xmi:id=//*[@xmi:id='$input']/@base_Class]/@name"/>
					</default:type>
				</arch:SystemRequirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='SystemRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Requirement.partOf.Requirement-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:Requirement_partOf_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.partOf.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_partOf_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Requirement_partOf_Requirement_Target>
					</arch:Requirement_partOf_Requirement>
				</xsl:for-each>
				<!--Requirement.satisfies.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<arch:Requirement_satisfies_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_Requirement.satisfies.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_satisfies_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:Requirement_satisfies_Requirement_Source>
						<arch:Requirement_satisfies_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:Requirement_satisfies_Requirement_Target>
					</arch:Requirement_satisfies_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<!--MechanicalComponent-->
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='TechnicalElement']/@base_Class]">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
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
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="*[local-name()='ownedAttribute']/@name"/>
					</default:type>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='TechnicalElement']/@base_Class]">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemComponent.partOf.SystemComponent-->
				<xsl:for-each select="./*/@xmi:id">
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
				<!--SystemComponent.specializes.SystemComponent-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<mech:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_specializes_SystemComponent_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:SystemComponent_specializes_SystemComponent_Source>
						<mech:SystemComponent_specializes_SystemComponent_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:SystemComponent_specializes_SystemComponent_Target>
					</mech:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent.provides.ComponentInterface-->
				<xsl:for-each select="/*[local-name()='ownedAttribute'][@xmi:type='uml:Port']/@xmi:id">
					<mech:SystemComponent_provides_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.provides.ComponentInterface_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_provides_ComponentInterface_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:SystemComponent_provides_ComponentInterface_Source>
						<mech:SystemComponent_provides_ComponentInterface_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:SystemComponent_provides_ComponentInterface_Target>
					</mech:SystemComponent_provides_ComponentInterface>
				</xsl:for-each>
				<!--SystemComponent.fulfils.Requirement-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref=$identifier]/*[local-name()='supplier']/@xmi:idref">
					<mech:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_fulfils_Requirement_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</mech:SystemComponent_fulfils_Requirement_Source>
						<mech:SystemComponent_fulfils_Requirement_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</mech:SystemComponent_fulfils_Requirement_Target>
					</mech:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<!--UseCase-->
			<xsl:for-each select="//*[@xmi:type='uml:UseCase']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
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
						<xsl:value-of select="@xmi:id"/>
					</default:identifier>
					<default:title>
						<xsl:value-of select="@name"/>
					</default:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</arch:UseCase>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:UseCase']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--UseCase.partOf.UseCase-->
				<xsl:for-each select="./*/@xmi:id">
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
				<!--UseCase.specializes.UseCase-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<arch:UseCase_specializes_UseCase>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_UseCase.specializes.UseCase_',.)"/>
						</xsl:attribute>
						<arch:UseCase_specializes_UseCase_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:UseCase_specializes_UseCase_Source>
						<arch:UseCase_specializes_UseCase_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:UseCase_specializes_UseCase_Target>
					</arch:UseCase_specializes_UseCase>
				</xsl:for-each>
				<!--UseCase.ownedBy.Role-->
				<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:idRef=$identifier]/*[local-name()='client']/@xmi:idRef">
					<arch:UseCase_ownedBy_Role>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($packageUri, $identifier,'_UseCase.ownedBy.Role_',.)"/>
						</xsl:attribute>
						<arch:UseCase_ownedBy_Role_Source>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri, $identifier)"/>
							</xsl:attribute>
						</arch:UseCase_ownedBy_Role_Source>
						<arch:UseCase_ownedBy_Role_Target>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="concat($packageUri,.)"/>
							</xsl:attribute>
						</arch:UseCase_ownedBy_Role_Target>
					</arch:UseCase_ownedBy_Role>
				</xsl:for-each>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>