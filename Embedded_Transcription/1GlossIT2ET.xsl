<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case: Turn connected TEIs into embedded transcription TEIs
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xd xsl" version="2.0">
    <xsl:variable name="pathToFolder" select="'/Users/bernhardbauer/Nextcloud/GlossIT/4_Data/PCr/connected'"/>    
   
    <xsl:variable name="varCollection">
        <xsl:copy-of 
            select="collection(concat('file:///', $pathToFolder, '?select=*.xml;recurse=yes'))
            "/> <!-- [matches(document-uri(.),'AuthorIndex/9[0-9][0-9][0-9]/.*?main.xml')]-->>
    </xsl:variable>
    
    <xsl:template match="/">
       <TEI xmlns="http://www.tei-c.org/ns/1.0">
           <teiHeader xml:lang="en">
               <fileDesc>
                   <titleStmt>
                       <title/>
                       <author ana="marcrelator:aut">
                           <persName ref="http://d-nb.info/gnd/118508237">Beda Venerabilis</persName>
                       </author>
                       <editor ana="marcrelator:edt">
                           <persName>
                               <forename>Bernhard</forename>
                               <surname>Bauer</surname>
                           </persName>
                       </editor>
                       <respStmt ana="marcrelator:trc">
                           <resp>Transcription from Original MS</resp>
                           <persName>
                               <forename>Bernhard</forename>
                               <surname>Bauer</surname>
                           </persName>
                           <persName>
                               <forename>Francesca</forename>
                               <surname>Guido</surname>
                           </persName>
                       </respStmt>
                       <respStmt ana="marcrelator:mrk">
                           <resp>XML encoding</resp>
                           <persName>
                               <forename>Bernhard</forename>
                               <surname>Bauer</surname>
                           </persName>
                           <persName>
                               <forename>Sina</forename>
                               <surname>Krottmaier</surname>
                           </persName>
                       </respStmt>
                       <funder ana="marcrelator:fnd">
                           <orgName ref="https://erc.europa.eu/homepage/">European Research Council</orgName>
                           <num>Grant agreement No. 101123203</num>
                           <name type="award">EU Horizon Europe ERC Consolidator-Grant</name>
                       </funder>
                   </titleStmt>
                   <publicationStmt>
                       <publisher>
                           <orgName corresp="https://informationsmodellierung.uni-graz.at"
                               ref="http://d-nb.info/gnd/1137284463">Department of Digital Humanities, University of Graz</orgName>
                       </publisher>
                       <authority ana="marcrelator:his">
                           <orgName corresp="https://informationsmodellierung.uni-graz.at"
                               ref="http://d-nb.info/gnd/1137284463">Department of Digital Humanities, University of Graz</orgName>
                       </authority>
                       <distributor ana="marcrelator:rps">
                           <orgName ref="https://gams.uni-graz.at">GAMS - Geisteswissenschaftliches Asset Management System</orgName>
                       </distributor>
                       <availability>
                           <licence target="https://creativecommons.org/licenses/by-nc/4.0">Creative Commons BY-NC 4.0</licence>
                       </availability>
                       <date ana="dcterms:issued" when="2017">2017</date>
                       <pubPlace ana="marcrelator:pup">Graz</pubPlace>
                       <idno type="PID">o:pid.1</idno>
                   </publicationStmt>
                   <seriesStmt>
                       <title ref="https://gams.uni-graz.at/glossit"> GlossIT: Celtic and Latin glossing traditions: uncovering early medieval language contact and knowledge transfer </title>
                       <title ref="https://gams.uni-graz.at/glossit" xml:lang="de"> GlossIT: Keltische und lateinische Glossen als Quellen für frühmittelalterlichen Sprachkontakt und Wissenstransfer </title>
                       <respStmt ana="marcrelator:pdr">
                           <resp>Principal Investigator</resp>
                           <persName>
                               <forename>Bernhard</forename>
                               <surname>Bauer</surname>
                           </persName>
                       </respStmt>
                       <respStmt ana="marcrelator:res">
                           <resp>DDH Mitarbeiter</resp>
                           <persName>
                               <forename>Sarah</forename>
                               <surname>Berghofer</surname>
                           </persName>
                           <persName>
                               <forename>Francesca</forename>
                               <surname>Guido</surname>
                           </persName>
                           <persName>
                               <forename>Paula</forename>
                               <surname>Harrison</surname>
                           </persName>
                           <persName>
                               <forename>Felix</forename>
                               <surname>Hutter</surname>
                           </persName>
                           <persName>
                               <forename>Sina</forename>
                               <surname>Krottmaier</surname>
                           </persName>
                           <persName>
                               <forename>Carolina</forename>
                               <surname>Mairinger</surname>
                           </persName>
                           <persName>
                               <forename>Annabelle</forename>
                               <surname>Kienzl</surname>
                           </persName>
                           <persName>
                               <forename>Tristan</forename>
                               <surname>Repolusk</surname>
                           </persName>
                       </respStmt>
                   </seriesStmt>
                   <sourceDesc>
                       <msDesc ana="gams:Manuscript">
                           <msIdentifier>
                               <settlement/>
                               <repository/>
                               <idno ana="dcterms:source"/>
                               <altIdentifier>
                                   <idno type="GlossIT"/>
                               </altIdentifier>
                           </msIdentifier>
                           <msContents>
                               <msItem ana="gams:MsItem">
                                   <locus from="" to=""/>
                                   <author ana="dcterms:author"/>
                                   <title ana="dcterms:title"/>
                                   <textLang ana="dcterms:language" mainLang="" n="text"/>
                                   <textLang mainLang="" n="gloss" otherLangs=""/>
                               </msItem>
                           </msContents>
                           <physDesc>
                               <objectDesc>
                                   <supportDesc>
                                       <support ana="dcterms:medium">
                                           <p/>
                                       </support>
                                   </supportDesc>
                               </objectDesc>
                           </physDesc>
                           <history>
                               <origin>
                                   <origDate ana="dcterms:date">
                                       <date notAfter="" notBefore=""/>
                                   </origDate>
                               </origin>
                           </history>
                           <additional>
                               <surrogates>
                                   <listRef>
                                       <ref ana="rdfs:seeAlso" corresp="link" n="catalogue"/>
                                       <ref corresp="link" n="facsimile"/>
                                   </listRef>
                               </surrogates>
                           </additional>
                       </msDesc>
                   </sourceDesc>
               </fileDesc>
               <encodingDesc>
                   <editorialDecl>
                       <p>was über die editionsregeln und kodierungsrichtlinien</p>
                   </editorialDecl>
                   <projectDesc>
                       <ab>
                           <ref target="context:glossit" type="context">GlossIT Context</ref>
                       </ab>
                       <p>Glosses are fingerprints of the society in which texts were composed, copied, and read. Most importantly, they play a much more significant role than previous research has acknowledged and offer insights about the multilingual and multi-ethnic environment of medieval manuscript
                           and text production the principal texts cannot: they are first-hand testimonies of the close linguistic and cultural connections between Insular Celtic (Old Breton, Old Irish, Old Welsh) and Latin speakers. GLOSSIT researches these contacts combining methods of comparative
                           philology and historical linguistics, digital humanities (handwritten text recognition, network analysis, natural language processing), (cultural) history, and biological computation (applying DNA-sequence alignment methods to glosses).</p>
                   </projectDesc>
                   <listPrefixDef>
                       <prefixDef ident="marcrelator"
                           matchPattern="([a-z]+)"
                           replacementPattern="http://id.loc.gov/vocabulary/relators/$1">
                           <p>Taxonomie Rollen MARC</p>
                       </prefixDef>
                       <prefixDef ident="dcterms"
                           matchPattern="([a-z]+)"
                           replacementPattern="http://purl.org/dc/terms/$1">
                           <p>DCterms</p>
                       </prefixDef>
                   </listPrefixDef>
               </encodingDesc>
               <profileDesc>
                   <langUsage>
                       <language ident="la">Latin</language>
                   </langUsage>
                   <textClass>
                       <keywords scheme="#">
                           <list>
                               <item>
                                   <term>Digital Humanities</term>
                               </item>
                               <item>
                                   <term>Early Medieval</term>
                               </item>
                               <item>
                                   <term>Glossing</term>
                               </item>
                           </list>
                       </keywords>
                   </textClass>
               </profileDesc>
           </teiHeader>
           <sourceDoc>
          <xsl:for-each select="$varCollection//t:TEI">
              <!--<surface lrx="{/t:facsimile/t:surface/@lrx}" lry="{/t:facsimile/t:surface/@lry}" ulx="{/t:facsimile/t:surface/@ulx}" uly="{/t:facsimile/t:surface/@uly}" xml:id="{/t:facsimile/t:surface/@xml:id}">-->
                <!-- <xsl:copy-of select="/t:facsimile/t:surface/t:graphic"/>-->
              <xsl:apply-templates select="* | @* | text()"/><!--</surface>-->               
       </xsl:for-each>
           </sourceDoc>
       </TEI>
    </xsl:template>
    
    <xsl:template match="t:text"/>
     
    <xsl:template match="t:surface">
        <surface lrx="{@lrx}" lry="{@lry}" ulx="{@ulx}" uly="{@uly}" xml:id="{@xml:id}">
            <xsl:copy-of select="./t:graphic"/>
            <xsl:for-each select="child::t:zone[@rendition='TextRegion']">
                    <zone>
                        <xsl:copy-of select="@*[not(name() = 'rotate')]"/>
                        <xsl:apply-templates select="node()"/>
                    </zone>
            </xsl:for-each>

        </surface>
    </xsl:template>
    
    
    <xsl:template match="t:zone/t:zone">
        <!--<!-\\-Setting up the zones and importing the respective lines, i.e. main text, glosses, folio-numbers-\\->-->
        <xsl:variable name="id" select="@xml:id"/>
        <xsl:variable name="line_text" select="//t:ab[@facs = concat('#', $id)]"/>
        <xsl:variable name="gloss" select="concat(@xml:id, '_gloss')"/>
        <xsl:choose>
            <xsl:when test="//t:ab[@facs = concat('#', $id)]/@type = 'textline'">
<!--                <!-\\-                For headings-\\->-->
                <xsl:choose>
                    <xsl:when test="//t:ab[@facs = concat('#', $id)]/@subtype">
                        <zone>
                            <xsl:attribute name="type">
                                <xsl:text>textline</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="substring-after(concat(//t:ab[@facs = concat('#', $id)]/@facs, '_heading'), '#')"
                                />
                            </xsl:attribute>
                            <xsl:attribute name="rendition">
                                <xsl:text>heading</xsl:text>
                            </xsl:attribute>
                            <line>
                                <xsl:attribute name="rendition">
                                    <xsl:text>heading</xsl:text>
                                </xsl:attribute>
                                <xsl:copy-of select="//t:zone[@xml:id = $id]/@*[not(name() = 'rotate')]"/>

                                <xsl:for-each select="//t:ab[@facs = concat('#', $id)]/t:w">
                                    <xsl:copy-of select="."/>
                                </xsl:for-each>
                            </line>
                        </zone>
                    </xsl:when>
<!--                    <!-\\-For main text-\\->-->
                    <xsl:otherwise>
                        <zone>
                            <xsl:attribute name="type">
                                <xsl:text>textline</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="substring-after(concat(//t:ab[@facs = concat('#', $id)]/@facs, '_maintext'), '#')"
                                />
                            </xsl:attribute>
                            <xsl:attribute name="rendition">
                                <xsl:text>maintext</xsl:text>
                            </xsl:attribute>
                            <line>
                                <xsl:attribute name="rendition">
                                    <xsl:text>textline</xsl:text>
                                </xsl:attribute>
                                <xsl:copy-of select="//t:zone[@xml:id = $id]/@*[not(name() = 'rotate')]"/>

                                <xsl:for-each select="//t:ab[@facs = concat('#', $id)]/t:w">
                                    <xsl:copy-of select="."/>
                                </xsl:for-each>
                            </line>
                        </zone>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="//t:gloss/@xml:id = $gloss">
                <!--<!-\\-For glosses-\\->-->
                <zone>
                    <xsl:attribute name="type">
                        <xsl:text>gloss</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="corresp">
                        <xsl:value-of select="//t:gloss[@xml:id = $gloss]/@target"/>
                    </xsl:attribute>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="//t:gloss[@xml:id = $gloss]/@xml:id"/>
                    </xsl:attribute>
                    <xsl:attribute name="rendition">
                        <xsl:value-of select="//t:gloss[@xml:id = $gloss]/@rendition"/>
                    </xsl:attribute>
                    <xsl:for-each select="//t:gloss[@xml:id = $gloss]/t:ab">
                        <line>
                            <xsl:variable name="line_id">
                                <xsl:value-of select="substring-after(@facs, '#')"/>
                            </xsl:variable>
                            <xsl:attribute name="rendition">
                                <xsl:value-of select="parent::t:gloss[@xml:id = $gloss]/@rendition"/>
                            </xsl:attribute>
                            <xsl:copy-of select="//t:zone[@xml:id = $line_id]/@*[not(name() = 'rotate' or name()= 'rendition')]"/>
                            <xsl:apply-templates select="text()"/>
                        </line>
                    </xsl:for-each>
                </zone>
            </xsl:when>
            <xsl:when test="//t:fw/@facs = $id">
<!--                <!-\\-For folio/page numbers-\\->-->
                <zone>
                    <xsl:attribute name="type">
                        <xsl:text>numbering</xsl:text>
                    </xsl:attribute>
                    <line>
                        <xsl:attribute name="rendition">
                            <xsl:value-of select="//t:fw[@facs = $id]/@type"/>
                        </xsl:attribute>
                        <xsl:copy-of select="//t:zone[@xml:id = $id]/@*[not(name() = 'rotate')]"/>
                        <xsl:apply-templates select="//t:fw[@facs = $id]/text()"/>
                    </line>
                </zone>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="t:teiHeader"/>
    
    
    
</xsl:stylesheet>
