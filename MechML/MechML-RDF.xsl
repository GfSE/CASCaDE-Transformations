<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:default="http://www.omg.org/spec/CASCaRA/ontology/" xmlns:cas="http://www.omg.org/spec/CASCaRA/metamodel/" xmlns:arch="http://www.omg.org/spec/CASCaRA/ontology/ProductArchitecture/" xmlns:mech="http://www.omg.org/spec/CASCaRA/ontology/MechanicalDesign/" xmlns:org="http://www.omg.org/spec/CASCaRA/ontology/Organization/" xmlns:sys="http://www.omg.org/spec/CASCaRA/ontology/SystemsDesign/" version="1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<owl:Ontology>
				<xsl:attribute name="rdf:about">
					<xsl:value-of select="concat('http://www.example.org/', generate-id(), '/')"/>
				</xsl:attribute>
				<owl:imports rdf:resource="http://www.omg.org/spec/CASCaRA/ontology/"/>
			</owl:Ontology>
			<xsl:for-each select="//*[@xmi:type='uml:AcceptEventAction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(//*[@base_Class='$input']/@Id, ' ', @name))"/>
				</xsl:variable>
				<!--ComponentState-->
				<sys:ComponentState>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<default:number>
						<xsl:value-of select="//*[@base_Class='$input']/@Id"/>
					</default:number>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:ComponentState>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:AcceptEventAction']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--ComponentState relations-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:ComponentState_partOf_ComponentState>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_ComponentState.partOf.ComponentState_',.)"/>
						</xsl:attribute>
						<sys:ComponentState_partOf_ComponentState_Source>
							<xsl:value-of select="$input"/>
						</sys:ComponentState_partOf_ComponentState_Source>
						<sys:ComponentState_partOf_ComponentState_Target>
							<xsl:value-of select="."/>
						</sys:ComponentState_partOf_ComponentState_Target>
					</sys:ComponentState_partOf_ComponentState>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Actor']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
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
				</org:Role>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Actor']/ancestor-or-self::*">
				<xsl:variable name="identifier">
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
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='User']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
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
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
				</org:Role>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='User']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
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
			<xsl:for-each select="//*[@xmi:type='uml:Class' and (@xmi:id=//*[local-name()='Block']/@base_Class or @xmi:id=//*[local-name()='element'][*[local-name()='properties']/@stereotype='Logical block']/@xmi:idref)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and (@xmi:id=//*[local-name()='Block']/@base_Class or @xmi:id=//*[local-name()='element'][*[local-name()='properties']/@stereotype='Logical block']/@xmi:idref)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
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
				<xsl:for-each select="./*[local-name()='type']/@xmi:idref">
					<sys:SystemComponent_usedIn_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.usedIn.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_usedIn_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_usedIn_SystemComponent_Source>
						<sys:SystemComponent_usedIn_SystemComponent_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_usedIn_SystemComponent_Target>
					</sys:SystemComponent_usedIn_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
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
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Property' and local-name()!='ownedEnd' and (./*[local-name()='type']/@xmi:idref=//*[local-name()='Block']/@base_Class or ./*[local-name()='type']/@xmi:idref=//*[local-name()='element'][*[local-name()='properties']/@stereotype='Logical block']/@xmi:idref)]">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Property' and local-name()!='ownedEnd' and (./*[local-name()='type']/@xmi:idref=//*[local-name()='Block']/@base_Class or ./*[local-name()='type']/@xmi:idref=//*[local-name()='element'][*[local-name()='properties']/@stereotype='Logical block']/@xmi:idref)]">
				<xsl:variable name="identifier">
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
				<xsl:for-each select="./*[local-name()='type']/@xmi:idref">
					<sys:SystemComponent_usedIn_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.usedIn.SystemComponent_',.)"/>
						</xsl:attribute>
						<sys:SystemComponent_usedIn_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</sys:SystemComponent_usedIn_SystemComponent_Source>
						<sys:SystemComponent_usedIn_SystemComponent_Target>
							<xsl:value-of select="."/>
						</sys:SystemComponent_usedIn_SystemComponent_Target>
					</sys:SystemComponent_usedIn_SystemComponent>
				</xsl:for-each>
				<!--SystemComponent relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
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
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Component']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Component']/ancestor-or-self::*">
				<xsl:variable name="identifier">
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
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
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
			<xsl:for-each select="//*[@xmi:type='uml:UseCase' and starts-with(@name, 'Fehlfunktion')]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(//*[@base_Class='$input']/@Id, ' ', @name))"/>
				</xsl:variable>
				<!--Deviation-->
				<sys:Deviation>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<default:number>
						<xsl:value-of select="//*[@base_Class='$input']/@Id"/>
					</default:number>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:Deviation>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:UseCase' and starts-with(@name, 'Fehlfunktion')]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Deviation relations-->
				<xsl:for-each select="./*/@xmi:id">
					<sys:Deviation_partOf_Deviation>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Deviation.partOf.Deviation_',.)"/>
						</xsl:attribute>
						<sys:Deviation_partOf_Deviation_Source>
							<xsl:value-of select="$input"/>
						</sys:Deviation_partOf_Deviation_Source>
						<sys:Deviation_partOf_Deviation_Target>
							<xsl:value-of select="."/>
						</sys:Deviation_partOf_Deviation_Target>
					</sys:Deviation_partOf_Deviation>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Activity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
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
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</arch:Function>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Activity']/ancestor-or-self::*">
				<xsl:variable name="identifier">
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
				<xsl:for-each select="//*[@xmi:type='uml:ControlFlow' and *[local-name()='target']='$input']/@source">
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
				<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:idref='$input']/*[local-name()='client']/@xmi:idref">
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
				<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:idref='$input']/*[local-name()='client']/@xmi:idref">
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
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='InterfaceBlock']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
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
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:ComponentInterface>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='InterfaceBlock']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
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
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Manifestation']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
				</xsl:variable>
				<!--SystemComponent-->
				<sys:SystemComponent>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</sys:SystemComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Manifestation']/ancestor-or-self::*">
				<xsl:variable name="identifier">
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
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
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
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
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
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
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
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='Requirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(//*[local-name()='Requirement'][@base_Class='$identifier']/@*[name()='id' or name()='Id'], ' ', @name))"/>
				</xsl:variable>
				<!--Requirement-->
				<arch:Requirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<default:number>
						<xsl:value-of select="//*[local-name()='Requirement'][@base_Class='$identifier']/@*[name()='id' or name()='Id']"/>
					</default:number>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="//*[local-name()='Requirement'][@base_Class='$identifier']/@*[name()='text' or name()='Text']"/>
					</dc:description>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</arch:Requirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='Requirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--Requirement relations-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:Requirement_partOf_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.partOf.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_partOf_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_partOf_Requirement_Target>
					</arch:Requirement_partOf_Requirement>
				</xsl:for-each>
				<!--Requirement relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
					<arch:Requirement_satisfies_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.satisfies.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_satisfies_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_satisfies_Requirement_Source>
						<arch:Requirement_satisfies_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_satisfies_Requirement_Target>
					</arch:Requirement_satisfies_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='StakeholderRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(@id|@Id, ' ', @name))"/>
				</xsl:variable>
				<!--StakeholderRequirement-->
				<arch:StakeholderRequirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<default:number>
						<xsl:value-of select="@id|@Id"/>
					</default:number>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="//*[@xmi:id='$input']/@Text"/>
					</dc:description>
					<default:type>
						<xsl:value-of select="//*[@xmi:id=//*[@xmi:id='$input']/@base_Class]/@name"/>
					</default:type>
				</arch:StakeholderRequirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='StakeholderRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--StakeholderRequirement relations-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:Requirement_partOf_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.partOf.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_partOf_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_partOf_Requirement_Target>
					</arch:Requirement_partOf_Requirement>
				</xsl:for-each>
				<!--StakeholderRequirement relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
					<arch:Requirement_satisfies_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.satisfies.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_satisfies_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_satisfies_Requirement_Source>
						<arch:Requirement_satisfies_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_satisfies_Requirement_Target>
					</arch:Requirement_satisfies_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=(//local-name()='System']/@base_Class)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
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
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="*[local-name()='ownedAttribute']/@name"/>
					</default:type>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=(//local-name()='System']/@base_Class)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--MechanicalComponent relations-->
				<xsl:for-each select="./*/@xmi:id">
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
				<!--MechanicalComponent relations-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<mech:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_specializes_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_specializes_SystemComponent_Source>
						<mech:SystemComponent_specializes_SystemComponent_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_specializes_SystemComponent_Target>
					</mech:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--MechanicalComponent relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
					<mech:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_fulfils_Requirement_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_fulfils_Requirement_Source>
						<mech:SystemComponent_fulfils_Requirement_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_fulfils_Requirement_Target>
					</mech:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and (@xmi:id=//*[local-name()='functionalRequirement']/@base_Class)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(@id|@Id, ' ', //*[@xmi:id='$input']/@name))"/>
				</xsl:variable>
				<!--SystemRequirement-->
				<arch:SystemRequirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<default:number>
						<xsl:value-of select="@id|@Id"/>
					</default:number>
					<dc:title>
						<xsl:value-of select="//*[@xmi:id='$input']/@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="@text|@Text"/>
					</dc:description>
					<default:type>
						<xsl:value-of select="//*[@xmi:id=//*[@xmi:id='$input']/@base_Class]/@name"/>
					</default:type>
				</arch:SystemRequirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and (@xmi:id=//*[local-name()='functionalRequirement']/@base_Class)]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemRequirement relations-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:Requirement_partOf_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.partOf.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_partOf_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_partOf_Requirement_Target>
					</arch:Requirement_partOf_Requirement>
				</xsl:for-each>
				<!--SystemRequirement relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
					<arch:Requirement_satisfies_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.satisfies.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_satisfies_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_satisfies_Requirement_Source>
						<arch:Requirement_satisfies_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_satisfies_Requirement_Target>
					</arch:Requirement_satisfies_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='SystemRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(concat(@id|@Id, ' ', @name))"/>
				</xsl:variable>
				<!--SystemRequirement-->
				<arch:SystemRequirement>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$identifier"/>
					</xsl:attribute>
					<xsl:element name="rdfs:label">
						<xsl:value-of select="$label"/>
					</xsl:element>
					<dc:identifier>
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<default:number>
						<xsl:value-of select="@id|@Id"/>
					</default:number>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<dc:description>
						<xsl:value-of select="//*[@xmi:id='$input']/@Text"/>
					</dc:description>
					<default:type>
						<xsl:value-of select="//*[@xmi:id=//*[@xmi:id='$input']/@base_Class]/@name"/>
					</default:type>
				</arch:SystemRequirement>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='SystemRequirement']/@base_Class]/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--SystemRequirement relations-->
				<xsl:for-each select="./*/@xmi:id">
					<arch:Requirement_partOf_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.partOf.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_partOf_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_partOf_Requirement_Source>
						<arch:Requirement_partOf_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_partOf_Requirement_Target>
					</arch:Requirement_partOf_Requirement>
				</xsl:for-each>
				<!--SystemRequirement relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
					<arch:Requirement_satisfies_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_Requirement.satisfies.Requirement_',.)"/>
						</xsl:attribute>
						<arch:Requirement_satisfies_Requirement_Source>
							<xsl:value-of select="$input"/>
						</arch:Requirement_satisfies_Requirement_Source>
						<arch:Requirement_satisfies_Requirement_Target>
							<xsl:value-of select="."/>
						</arch:Requirement_satisfies_Requirement_Target>
					</arch:Requirement_satisfies_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='TechnicalElement']/@base_Class]">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
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
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="*[local-name()='ownedAttribute']/@name"/>
					</default:type>
				</mech:MechanicalComponent>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:Class' and @xmi:id=//*[local-name()='TechnicalElement']/@base_Class]">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<!--MechanicalComponent relations-->
				<xsl:for-each select="./*/@xmi:id">
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
				<!--MechanicalComponent relations-->
				<xsl:for-each select="*[local-name()='generalization']/@general">
					<mech:SystemComponent_specializes_SystemComponent>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.specializes.SystemComponent_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_specializes_SystemComponent_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_specializes_SystemComponent_Source>
						<mech:SystemComponent_specializes_SystemComponent_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_specializes_SystemComponent_Target>
					</mech:SystemComponent_specializes_SystemComponent>
				</xsl:for-each>
				<!--MechanicalComponent relations-->
				<xsl:for-each select="/*[local-name()='ownedAttribute'][@xmi:type='uml:Port']/@xmi:id">
					<mech:SystemComponent_provides_ComponentInterface>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.provides.ComponentInterface_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_provides_ComponentInterface_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_provides_ComponentInterface_Source>
						<mech:SystemComponent_provides_ComponentInterface_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_provides_ComponentInterface_Target>
					</mech:SystemComponent_provides_ComponentInterface>
				</xsl:for-each>
				<!--MechanicalComponent relations-->
				<xsl:for-each select="//*[*[local-name()='client']/@xmi:idref='$input']/*[local-name()='supplier']/@xmi:idref">
					<mech:SystemComponent_fulfils_Requirement>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="concat($input,'_SystemComponent.fulfils.Requirement_',.)"/>
						</xsl:attribute>
						<mech:SystemComponent_fulfils_Requirement_Source>
							<xsl:value-of select="$input"/>
						</mech:SystemComponent_fulfils_Requirement_Source>
						<mech:SystemComponent_fulfils_Requirement_Target>
							<xsl:value-of select="."/>
						</mech:SystemComponent_fulfils_Requirement_Target>
					</mech:SystemComponent_fulfils_Requirement>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:UseCase']/ancestor-or-self::*">
				<xsl:variable name="identifier">
					<xsl:value-of select="@xmi:id"/>
				</xsl:variable>
				<xsl:variable name="label">
					<xsl:value-of select="normalize-space(@name)"/>
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
						<xsl:value-of select="@xmi:id"/>
					</dc:identifier>
					<dc:title>
						<xsl:value-of select="@name"/>
					</dc:title>
					<default:type>
						<xsl:value-of select="@xmi:type"/>
					</default:type>
				</arch:UseCase>
			</xsl:for-each>
			<xsl:for-each select="//*[@xmi:type='uml:UseCase']/ancestor-or-self::*">
				<xsl:variable name="identifier">
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
				<xsl:for-each select="//*[*[local-name()='supplier']/@xmi:idRef='$input']/*[local-name()='client']/@xmi:idRef">
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