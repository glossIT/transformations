<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    ToDo: Add intermediate "notes" for progression tracking 
    THIS TRANSFORMATION IS FOR PAGE + IMAGES EXPORT
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:p="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15 http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15/pagecontent.xsd"
    xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:local="local"
    xmlns:xstring="https://github.com/dariok/XStringUtils" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xd:doc>
        <xd:desc>Entry point: start at the top of METS.xml</xd:desc>
    </xd:doc>
    <xsl:template match="/mets:mets" name="Mets" mode="#all">
        <TEI xmlns="http://www.tei-c.org/ns/1.0" rendition="glossit">
            <!-- es ist sinnvoll, die verwendete sprache möglichst weit oben in der hierarchie zu deklarieren und dann nur mehr abweichungen festzulegen -->
            <!-- aus den Guidelines:The xml:lang value will be inherited from the immediately enclosing element, or from its parent, and so on up the document hierarchy. It is generally good practice to specify xml:lang at the highest appropriate level, noticing that a different default may be needed for the teiHeader from that needed for the associated resource element or elements, and that a single TEI document may contain texts in many languages.
        The authoritative list of registered language subtags is maintained by IANA and is available at http://www.iana.org/assignments/language-subtag-registry. -->
            <teiHeader xml:lang="en">
                <fileDesc>
                    <!-- The key words must, must not, required, shall, shall not, should, should not, recommended, may, and optional in this document are to be interpreted as described in RFC 2119. -->
                    <!-- 
            Research team head [rth]   A person who directed or managed a research project
            Research team member [rtm]   A person who participated in a research project but whose role did not involve direction or management of it
            Researcher [res]   A person or organization responsible for performing research  UF Performer of research  
            Project director [pdr]   A person or organization with primary responsibility for all essential aspects of a project, has overall responsibility for managing projects, or provides overall direction to a project manager
            Repository [rps]   An organization that hosts data or material culture objects and provides services to promote long term, consistent and shared use of those data or objects
            Funder [fnd]   A person or organization that furnished financial support for the production of the work
            Author [aut]
            Editor [edt]
            Editor of compilation [edc] A person, family, or organization contributing to a collective or aggregate work by selecting and putting together works, or parts of works, by one or more creators. For compilations of data, information, etc., that result in new works, see compiler
            Markup editor [mrk] A person or organization performing the coding of SGML, HTML, or XML markup of metadata, text, etc.
            Publisher [pbl] A person or organization responsible for publishing, releasing, or issuing a resource
            Creator [cre] A person or organization responsible for the intellectual or artistic content of a resource
            Distribution place [dbp] A place from which a resource, e.g., a serial, is distributed
            Host institution [his] An organization hosting the event, exhibit, conference, etc., which gave rise to a resource, but having little or no responsibility for the content of the resource
            Publication place [pup] The place where a resource is published
            für Kofler: Writer of added commentary [wac] A person, family, or organization contributing to an expression of a work by providing an interpretation or critical explanation of the original work

            für weitere: https://www.loc.gov/marc/relators/relaterm.html
            -->
                    <!-- wenn nicht surname und forename dann  <persName>Nachname, Vorname</persName> -->
                    <titleStmt>
                        <!-- REQUIRED -->
                        <title>
                            <xsl:variable name="docNum">
                                <xsl:analyze-string select="base-uri()" regex="doc\d+_">
                                    <xsl:matching-substring>
                                        <xsl:value-of select="."/>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>
                            </xsl:variable>
                            <xsl:variable name="docName">
                                <xsl:value-of
                                    select="translate(substring-before(substring-after(base-uri(), $docNum), '_pagexml'), '_', ' ')"
                                />
                            </xsl:variable>
                            <xsl:value-of select="$docName"/>
                            <!--                            <xsl:value-of
                                select="concat(upper-case(substring($docName, 1, 1)), substring($docName, 2))"
                            />-->
                        </title>
                        <!-- abhängig von der Benennung des Dokuments in eScriptorium -->
                        <author ana="marcrelator:aut">
                            <persName ref="http://d-nb.info/gnd/118508237">Beda
                                Venerabilis</persName>
                        </author>
                        <!-- oder <persName>Nachname, Vorname</persName>-->
                        <!-- autor der quelle -->
                        <!-- einer der Marcrelator (edt oder trc oder mrk) sollte zumindest vorhanden sein- hier alle 3 nur als Beipiel vorhanden -->
                        <!-- RECOMMENDED aber Beispiel   -->
                        <editor ana="marcrelator:edt">
                            <persName>
                                <forename>Bernhard</forename>
                                <surname>Bauer</surname>
                            </persName>
                        </editor>
                        <!-- RECOMMENDED aber Beispiel -->
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
                        <!-- RECOMMENDED aber Beispiel -->
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
                        <!-- RECOMMENDED -->
                        <funder ana="marcrelator:fnd">
                            <orgName ref="https://erc.europa.eu/homepage/">European Research
                                Council</orgName>
                            <num>Grant agreement No. 101123203</num>
                            <name type="award">EU Horizon Europe ERC Consolidator-Grant</name>
                        </funder>
                    </titleStmt>
                    <publicationStmt>
                        <!-- publicationStmt sollte unverändert übernommen werden, fixer platz für projektpartner, zim und gams -->
                        <!-- REQUIRED -->
                        <publisher>
                            <orgName ref="http://d-nb.info/gnd/1137284463"
                                corresp="https://informationsmodellierung.uni-graz.at"
                                ><!-- anpassen -->Department of Digital Humanities, University of
                                Graz</orgName>
                        </publisher>
                        <!-- REQUIRED -->
                        <authority ana="marcrelator:his">
                            <orgName ref="http://d-nb.info/gnd/1137284463"
                                corresp="https://informationsmodellierung.uni-graz.at">Department of
                                Digital Humanities, University of Graz</orgName>
                        </authority>
                        <!-- REQUIRED -->
                        <distributor ana="marcrelator:rps">
                            <orgName ref="https://gams.uni-graz.at">GAMS - Geisteswissenschaftliches
                                Asset Management System</orgName>
                        </distributor>
                        <!-- REQUIRED -->
                        <availability>
                            <licence target="https://creativecommons.org/licenses/by-nc/4.0"
                                >Creative Commons BY-NC 4.0</licence>
                            <!-- richtige lizenz auswählen -->
                        </availability>
                        <!-- RECOMMENDED -->
                        <date when="2017" ana="dcterms:issued">2017</date>
                        <!-- Publikationsdatum anpassen-->
                        <!-- dcterms:issued = wann das digitale objekt publiziert wurde-->
                        <!-- REQUIRED -->
                        <pubPlace ana="marcrelator:pup">Graz</pubPlace>
                        <!-- REQUIRED -->
                        <idno type="PID">o:pid.1</idno>
                    </publicationStmt>
                    <seriesStmt>
                        <!-- RECOMMENDED -->
                        <!-- im ref darf nicht der context url stehen also zb http://gams.uni-graz.at/context:fercan  sondern immer der ohne context!!!! -->
                        <title ref="https://gams.uni-graz.at/glossit"
                            ><!-- link ohne context --><!-- anpassen--> GlossIT: Celtic and Latin
                            glossing traditions: uncovering early medieval language contact and
                            knowledge transfer </title>
                        <title ref="https://gams.uni-graz.at/glossit" xml:lang="de"
                            ><!-- link ohne context --><!-- anpassen--> GlossIT: Keltische und
                            lateinische Glossen als Quellen für frühmittelalterlichen Sprachkontakt
                            und Wissenstransfer </title>
                        <!-- deutsch und englisch angeben -->
                        <!-- übergeordnetes Projekt mit Link angeben -->
                        <!--
               Research team head [rth]   A person who directed or managed a research project
               Research team member [rtm]   A person who participated in a research project but whose role did not involve direction or management of it 
               Project director [pdr]   A person or organization with primary responsibility for all essential aspects of a project, has overall responsibility for managing projects, or provides overall direction to a project manager
       -->
                        <!-- REQUIRED -->
                        <respStmt ana="marcrelator:pdr">
                            <resp>Principal Investigator</resp>
                            <persName>
                                <forename>Bernhard</forename>
                                <surname>Bauer</surname>
                            </persName>
                        </respStmt>
                        <!-- RECOMMENDED -->
                        <respStmt ana="marcrelator:res">
                            <!--  Researcher-->
                            <resp>ZIM Mitarbeiter</resp>
                            <persName>
                                <forename>Francesca</forename>
                                <surname>Guido</surname>
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
                        </respStmt>
                    </seriesStmt>
                    <sourceDesc>
                        <msDesc ana="gams:Manuscript">
                            <msIdentifier>
                                <settlement/>
                                <repository/>
                                <idno ana="dcterms:source"/>
                                <altIdentifier>
                                <idno type="GlossIT">
                                    <!--Comes from the filename in eScriptorium-->
                                    <xsl:variable name="docNum">
                                        <xsl:analyze-string select="base-uri()" regex="doc\d+_">
                                            <xsl:matching-substring>
                                                <xsl:value-of select="."/>
                                            </xsl:matching-substring>
                                        </xsl:analyze-string>
                                    </xsl:variable>
                                    <xsl:variable name="docName">
                                        <xsl:value-of
                                            select="translate(substring-before(substring-after(base-uri(), $docNum), '_pagexml'), '_', ' ')"
                                        />      
                                    </xsl:variable>
                                    <xsl:value-of
                                        select="concat(upper-case(substring($docName, 1, 1)), substring($docName, 2))"
                                    />
                                </idno>                              
                                </altIdentifier>
                                                </msIdentifier>
                                                <msContents>
                                                    <msItem ana="gams:MsItem">
                                                        <locus from="" to=""/>
                                                        <author ana="dcterms:author"/>
                                                        <title ana="dcterms:title"/>
                                                        <textLang n="text" mainLang=""
                                                            ana="dcterms:language"/>
                                                        <textLang n="gloss" mainLang="" otherLangs=""/>
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
                                                            <date notBefore="" notAfter=""></date>
                                                        </origDate>
                                                    </origin>
                                                </history>
                                                <additional>
                                                    <surrogates>
                                                        <listRef>
                                                            <ref n="catalogue" corresp="link"
                                                                ana="rdfs:seeAlso"/>
                                                            <ref n="facsimile" corresp="link"/>
                                                        </listRef>
                                                    </surrogates>
                                                </additional>
                                            </msDesc>                               
                                            <note type="progress" n="finished"/>
                                        </sourceDesc>
                </fileDesc>                       
                <!-- RECOMMENDED wegen Projektbeschreibung -->
                <encodingDesc>
                    <editorialDecl>
                        <p>was über die editionsregeln und kodierungsrichtlinien</p>
                    </editorialDecl>
                    <projectDesc>
                        <ab>
                            <ref target="context:glossit" type="context">GlossIT Context</ref>
                            <!-- Wurzelkontext -->
                        </ab>
                        <!-- RECOMMENDED -->
                        <p>Glosses are fingerprints of the society in which texts were composed,
                            copied, and read. Most importantly, they play a much more significant
                            role than previous research has acknowledged and offer insights about
                            the multilingual and multi-ethnic environment of medieval manuscript and
                            text production the principal texts cannot: they are first-hand
                            testimonies of the close linguistic and cultural connections between
                            Insular Celtic (Old Breton, Old Irish, Old Welsh) and Latin speakers.
                            GLOSSIT researches these contacts combining methods of comparative
                            philology and historical linguistics, digital humanities (handwritten
                            text recognition, network analysis, natural language processing),
                            (cultural) history, and biological computation (applying DNA-sequence
                            alignment methods to glosses).</p>
                    </projectDesc>
                    <listPrefixDef>
                        <!-- Personen -->
                        <prefixDef ident="marcrelator" matchPattern="([a-z]+)"
                            replacementPattern="http://id.loc.gov/vocabulary/relators/$1">
                            <p>Taxonomie Rollen MARC</p>
                        </prefixDef>
                        <!-- Möglichkeit 1 https://tei-c.org/release/doc/tei-p5-doc/en/html/SA.html#SAPU-->
                        <!-- datum dcterms -->
                        <prefixDef ident="dcterms" matchPattern="([a-z]+)"
                            replacementPattern="http://purl.org/dc/terms/$1">
                            <p>DCterms</p>
                        </prefixDef>
                    </listPrefixDef>
                </encodingDesc>
                <profileDesc>
                    <langUsage>
                        <language ident="la">Latin</language>
                        <!-- sprache des originals, iana code -->
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
            <xsl:text>
            </xsl:text>          
            <facsimile>
                <xsl:apply-templates select="//mets:fileGrp[@USE = 'export']/mets:file"
                    mode="facsimile"/>
                <xsl:text>
            </xsl:text>
            </facsimile>
            <xsl:text>
            </xsl:text>
            <text>
                <xsl:text>
            </xsl:text>
                <body>
                    <xsl:text>
            </xsl:text>
                    <div>
                        <xsl:apply-templates select="//mets:fileGrp[@USE = 'export']/mets:file"
                            mode="text"/>
                    </div>
                </body>
                <xsl:text>
            </xsl:text>
            </text>
            <xsl:text>
            </xsl:text>
        </TEI>
    </xsl:template>
    <xd:doc>
        <xd:desc>
            <xd:p>Here we are creating the t:facsimile/t:surface for the TEI</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="mets:fileGrp[@USE = 'export']/mets:file" mode="facsimile">
        <xsl:variable name="file" select="document(mets:FLocat/@xlink:href, /)"/>
        <xsl:variable name="numCurr" select="substring-after(@ID, 't')"/>
        <xsl:apply-templates select="$file//p:Page" mode="facsimile">
            <xsl:with-param name="numCurr" select="$numCurr" tunnel="true"/>
        </xsl:apply-templates>
    </xsl:template>
    <xd:doc>
        <xd:desc>Here we are creating the t:text for the TEI</xd:desc>
    </xd:doc>
    <xsl:template match="mets:fileGrp[@USE = 'export']/mets:file" mode="text">
        <xsl:variable name="file" select="document(mets:FLocat/@xlink:href, /)"/>
        <xsl:variable name="numCurr" select="substring-after(@ID, 't')"/>
        <xsl:apply-templates select="$file//p:Page" mode="text">
            <xsl:with-param name="numCurr" select="$numCurr" tunnel="true"/>
        </xsl:apply-templates>
    </xsl:template>
    <!--    START OF THE FACSIMILE TEMPLATES-->
    <xd:doc>
        <xd:desc>Here we are creating the facsimile for each Page in the Page-XML</xd:desc>
        <xd:param name="numCurr">
            <xd:p>Numerus currens of the parent facsimile</xd:p>
        </xd:param>
    </xd:doc>
    <xsl:template match="p:Page" mode="facsimile">
        <xsl:param name="numCurr" tunnel="true"/>
        <xsl:variable name="imageWidth" select="@imageWidth"/>
        <xsl:variable name="imageHeight" select="@imageHeight"/>
        <xsl:variable name="ImageID" select="concat('IMAGE.', $numCurr)"/>
        <xsl:variable name="URL" select="@imageFilename"/>
        <xsl:text>
        </xsl:text>
        <surface ulx="0" uly="0" lrx="{$imageWidth}" lry="{$imageHeight}" xml:id="facs_{$numCurr}">
            <xsl:text>
            </xsl:text>
            <graphic url="{$URL}" height="{concat($imageHeight, 'px')}"
                width="{concat($imageWidth, 'px')}" xml:id="{$ImageID}"/>
            <xsl:apply-templates select="p:TextRegion" mode="facsimile"/>
        </surface>
    </xsl:template>
    <xd:doc>
        <xd:desc>Here we are creating the zones for the TextRegions within the
            facsimile/surface</xd:desc>
        <xd:param name="numCurr">Numerus currens of the current page</xd:param>
    </xd:doc>
    <xsl:template match="p:TextRegion" mode="facsimile">
        <xsl:param name="numCurr" tunnel="true"/>
        <xsl:call-template name="coords"/>
    </xsl:template>
    <xd:doc>
        <xd:desc>Here we are creating the zones for the Lines within the TextRegions</xd:desc>
        <xd:param name="numCurr">Numerus currens of the current page</xd:param>
    </xd:doc>
    <xsl:template match="p:TextLine" mode="facsimile">
        <xsl:param name="numCurr" tunnel="true"/>
        <xsl:call-template name="coords"/>
        <!-- x, rx, ry, y -->
    </xsl:template>
    <!--    START OF THE TEXT TEMPLATES-->
    <xd:doc>
        <xd:desc>Here we are creating the text for each Page in the Page-XML</xd:desc>
        <xd:param name="numCurr">Numerus currens of the current page</xd:param>
    </xd:doc>
    <xsl:template match="p:Page" mode="text">
        <xsl:param name="numCurr" tunnel="true"/>
        <xsl:variable name="URL" select="@imageFilename"/>
        <xsl:variable name="ImageID" select="concat('#IMAGE.', $numCurr)"/>
        <xsl:text>
        </xsl:text>
        <pb facs="{$ImageID}" corresp="{$URL}">
            <xsl:variable name="number">
                <xsl:choose>
                    <xsl:when
                        test="descendant::p:TextRegion/@custom = 'structure {type:NumberingZone:folio;}'">
                        <xsl:text>fol. </xsl:text>
                        <xsl:apply-templates
                            select="descendant::p:TextRegion[@custom = 'structure {type:NumberingZone:folio;}']/p:TextLine"
                            mode="text"/>
                        <xsl:text>r</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>p. </xsl:text>
                        <xsl:apply-templates
                            select="descendant::p:TextRegion[@custom = 'structure {type:NumberingZone:page;}']/p:TextLine"
                            mode="text"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="n">
                <xsl:value-of select="$number"/>
            </xsl:attribute>
        </pb>
        <note type="progress" n="finished"/>
        <xsl:apply-templates select="descendant::p:TextRegion" mode="text">
            <xsl:with-param name="numCurr" select="$numCurr" tunnel="true"/>
        </xsl:apply-templates>        
    </xsl:template>
    <xd:doc>
        <xd:desc>Here we are creating the text for each TextRegion in the Page-XML</xd:desc>
        <xd:param name="numCurr">Numerus currens of the current page</xd:param>
    </xd:doc>
    <xsl:template match="p:TextRegion" mode="text">
        <xsl:param name="numCurr" tunnel="true"/>
        <xsl:variable name="type" select="substring-before(substring-after(@custom, 'type:'), ';')"/>
        <xsl:text>
            </xsl:text>
        <xsl:choose>
            <xsl:when test="$type = 'NumberingZone:folio'">
                <fw type="folio-number" facs="{@id}">
                    <xsl:apply-templates select="descendant::p:TextLine" mode="text"/>
                </fw>
            </xsl:when>
            <xsl:when test="$type = 'NumberingZone:page'">
                <fw type="page-number" facs="{@id}">
                    <xsl:apply-templates select="descendant::p:TextLine" mode="text"/>
                </fw>
            </xsl:when>
            <xsl:when test="$type = 'Title'">
                <fw type="header" facs="{@id}">
                    <xsl:apply-templates select="descendant::p:TextLine" mode="text"/>
                </fw>
            </xsl:when>
            <xsl:otherwise>
<!--                <ab type="{$type}">-->
                    <xsl:for-each select="descendant::p:TextLine">
                        <xsl:variable name="line-type"
                            select="substring-before(substring-after(@custom, 'type:'), ';')"/>
                        <xsl:variable name="margin" select="substring-after($type, ':')"/>
                        <xsl:variable name="gloss-type">
                            <xsl:choose>
                                <xsl:when test="contains(@custom, 'Marginal')">
                                    <xsl:value-of select="concat(concat(upper-case(substring($margin, 1, 1)), substring($margin, 2)), substring-before(substring-after(@custom, 'type:'), ';'))"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring-before(substring-after(@custom, 'type:'), ';')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="($line-type = 'DefaultLine' or $line-type = 'default' or $line-type='')">
                                <xsl:text> </xsl:text>
                                
                            <xsl:variable name="gloss-type" select="substring-after(substring-before(substring-after(@custom, 'type:'), ';'), 'Line:')"/>
                      <xsl:choose>                         
                            <xsl:when test="($line-type = 'DefaultLine' or $line-type = 'default' or $line-type='')">
                                  <xsl:text></xsl:text>
                                <ab type="textline" facs="{concat( '#', @id)}">
                                    <xsl:apply-templates select="self::p:TextLine" mode="text">
                                        <xsl:with-param name="numCurr" select="$numCurr"
                                            tunnel="true"/>
                                    </xsl:apply-templates>
                                </ab>
                            </xsl:when>
                            <xsl:when test="not($line-type)">
                                <xsl:text></xsl:text>
                                <ab type="textline" facs="{concat( '#', @id)}">
                                    <xsl:apply-templates select="self::p:TextLine" mode="text">
                                        <xsl:with-param name="numCurr" select="$numCurr"
                                            tunnel="true"/>
                                    </xsl:apply-templates>
                                </ab>
                            </xsl:when>

                        </xsl:choose>
                            
                            </xsl:when>
                            <xsl:when test="$line-type = 'HeadingLine:title'">
                                <ab type="textline" subtype="heading" facs="{concat( '#', @id)}">
                                    <xsl:apply-templates select="self::p:TextLine" mode="text">
                                        <xsl:with-param name="numCurr" select="$numCurr"
                                            tunnel="true"/>
                                    </xsl:apply-templates>
                                </ab>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text></xsl:text>
                                <gloss rendition="{$gloss-type}" facs="{concat( '#', @id)}">
                                    <xsl:apply-templates select="self::p:TextLine" mode="text">
                                        <xsl:with-param name="numCurr" select="$numCurr"
                                            tunnel="true"/>
                                    </xsl:apply-templates>
                                </gloss>
                            </xsl:otherwise>
                               
                        </xsl:choose>
                              
                         
                    </xsl:for-each>
                <!--</ab>-->
                
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    <xd:doc>
        <xd:desc>Here we are creating the text for each TextLine in the Page-XML</xd:desc>
    </xd:doc>
    <xsl:template match="p:TextLine" mode="text">
        <!--<xsl:variable name="ID" select="@id"/>
        <lb facs="{concat('#',$ID)}"/>-->
        <xsl:apply-templates select="descendant::p:Unicode" mode="text"/>
    </xsl:template>
    <xd:doc>
        <xd:desc>Here we change the coordinate points to 4 points (x, rx, ry, y) for the Textregions
            and TextLines. var coords: changes the points to follow this pattern -X,Y-X,Y-... var
            xmin: sorts all the x coordinates lowest to highest; var ymin: sorts all the y
            coordinates from lowest to highest; var xmax: sorts all the x coordinates from highest
            to lowest; var ymax: sorts all the y coordinates from highest to lowest; var XYmin2:
            creates the coordinates for the left upper point; var XmaxYmin: creates the coordinates
            for the right upper point; var XYmax2: creates the coordinates for the right lower
            point; var XminYmax: creates the coordinates for the left lower point; </xd:desc>
    </xd:doc>
    
    <xsl:template name="coords">
        <xsl:variable name="base-coords"
            select="concat('-', translate(translate(./p:Baseline/@points, ' ', '-'), '-', '- '), '- ')"/>

        <xsl:variable name="b-Xmin">
            <x>
                <xsl:for-each select="tokenize(translate($base-coords, '-', ' '))">
                    <xsl:sort select="number(substring-before(., ','))" order="ascending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-before(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>             
                </xsl:for-each>
            </x>
        </xsl:variable>
        <xsl:variable name="b-Ymin">
            <y>
                <xsl:for-each select="tokenize(translate($base-coords, '-', ' '))">
                    <xsl:sort select="number(substring-after(., ','))" order="ascending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-after(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </y>
        </xsl:variable>
        <xsl:variable name="b-Xmax">
            <x>
                <xsl:for-each select="tokenize(translate($base-coords, '-', ' '))">
                    <xsl:sort select="number(substring-before(., ','))" order="descending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-before(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </x>
        </xsl:variable>
        <xsl:variable name="b-Ymax">
            <y>
                <xsl:for-each select="tokenize(translate($base-coords, '-', ' '))">
                    <xsl:sort select="number(substring-after(., ','))" order="descending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-after(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </y>
        </xsl:variable>
        <xsl:variable name="b-XYmin2"
            select="concat(substring-before($b-Xmin, ','), ',', substring-before($b-Ymin, ','))"/>
        <xsl:variable name="b-XmaxYmin"
            select="concat(substring-before($b-Xmax, ','), ',', substring-before($b-Ymin, ','))"/>
        <xsl:variable name="b-XYmax2"
            select="concat(substring-before($b-Xmax, ','), ',', substring-before($b-Ymax, ','))"/>
        <xsl:variable name="b-XminYmax"
            select="concat(substring-before($b-Xmin, ','), ',', substring-before($b-Ymax, ','))"/>
        <xsl:text>
        </xsl:text>
        <xsl:variable name="base-coords" select="concat($b-XYmin2, ' ', $b-XmaxYmin, ' ', $b-XYmax2, ' ', $b-XminYmax)"/>
        <xsl:variable name="coords"
            select="concat('-', translate(translate(./p:Coords/@points, ' ', '-'), '-', '- '), '- ')"/>
        <xsl:variable name="Xmin">
            <x>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-before(., ','))" order="ascending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-before(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                    <!--    <xsl:value-of select="substring-after(substring-before(., ','), '-')"/>-->
                </xsl:for-each>
            </x>
        </xsl:variable>
        <xsl:variable name="Ymin">
            <y>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-after(., ','))" order="ascending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-after(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </y>
        </xsl:variable>
        <xsl:variable name="Xmax">
            <x>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-before(., ','))" order="descending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-before(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>                  
                </xsl:for-each>
            </x>
        </xsl:variable>
        <xsl:variable name="Ymax">
            <y>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-after(., ','))" order="descending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-after(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </y>
        </xsl:variable>
        <xsl:variable name="XYmin2"
            select="concat(substring-before($Xmin, ','), ',', substring-before($Ymin, ','))"/>
        <xsl:variable name="XmaxYmin"
            select="concat(substring-before($Xmax, ','), ',', substring-before($Ymin, ','))"/>
        <xsl:variable name="XYmax2"
            select="concat(substring-before($Xmax, ','), ',', substring-before($Ymax, ','))"/>
        <xsl:variable name="XminYmax"
            select="concat(substring-before($Xmin, ','), ',', substring-before($Ymax, ','))"/>
        <xsl:variable name="ID" select="@id"/>
        <xsl:text>
        </xsl:text>
       <xsl:choose>
            <xsl:when test="name(.) = 'TextRegion'">
                <zone xmlns="http://www.tei-c.org/ns/1.0" ulx="{substring-before($Xmin, ',')}" uly="{substring-before($Ymin, ',')}" lrx="{substring-before($Xmax, ',')}" lry="{substring-before($Ymax, ',')}" rend="{concat($XYmin2, ' ', $XmaxYmin, ' ', $XYmax2, ' ', $XminYmax)}"
                    rotate="0" xml:id="{$ID}" rendtion="{'TextRegion'}">
                    <xsl:apply-templates select="p:TextLine" mode="facsimile"/>
                </zone>
            </xsl:when>
            <xsl:otherwise>
                <zone xmlns="http://www.tei-c.org/ns/1.0" rend="{concat($XYmin2, ' ', $XmaxYmin, ' ', $XYmax2, ' ', $XminYmax)}"
                    rotate="0" xml:id="{$ID}" rendtion="{'TextLine'}"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
