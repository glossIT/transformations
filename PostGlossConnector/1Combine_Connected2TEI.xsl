<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case:
    This prepare the given pageXML for the next step.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" version="3.0">
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xd:doc>
        <xd:desc>Entry point: start at the top of METS_connected.xml</xd:desc>
    </xd:doc>
    <xsl:template match="/mets:mets">
        
        <TEI xmlns="http://www.tei-c.org/ns/1.0" rendition="glossit">
            <teiHeader xml:lang="en">
                <xsl:apply-templates select="//mets:fileGrp[@USE = 'export']/mets:file" mode="header"/>
            </teiHeader>
            <facsimile>
                <xsl:apply-templates select="//mets:fileGrp[@USE = 'export']/mets:file" mode="facsimile"/>
                <xsl:text>
            </xsl:text>
            </facsimile>
            <xsl:text>
            </xsl:text>
            <text>
                <xsl:text>
            </xsl:text>

                      <body>  <xsl:apply-templates select="//mets:fileGrp[@USE = 'export']/mets:file" mode="body"/></body>

            </text>
            <xsl:text>
            </xsl:text>
        </TEI>
    </xsl:template>

    <xd:doc>
        <xd:desc>Here we choose the first header, which is the header of the combining TEI</xd:desc>
    </xd:doc>    
    <xsl:template match="mets:fileGrp[@USE = 'export']/mets:file[1]" mode="header">
        <xsl:variable name="file" select="document(mets:FLocat/@xlink:href, /)"/>
        <xsl:copy-of select="$file//t:TEI/t:teiHeader/node()"/>
    </xsl:template>

    <xd:doc>
        <xd:desc>Here we copy the facs of all TEIs into one facs</xd:desc>
    </xd:doc>
    <xsl:template match="mets:fileGrp[@USE = 'export']/mets:file" mode="facsimile">
        <xsl:variable name="file" select="document(mets:FLocat/@xlink:href, /)"/>
        <xsl:copy-of select="$file//t:TEI/t:facsimile/node()"/>
    </xsl:template>

    <xd:doc>
        <xd:desc>Here we copy the bodies of all TEIs into one body</xd:desc>
    </xd:doc>
    <xsl:template match="mets:fileGrp[@USE = 'export']/mets:file" mode="body">
        <xsl:variable name="file" select="document(mets:FLocat/@xlink:href, /)"/>
        <xsl:copy-of select="$file//t:TEI/t:text/t:body/node()"/>
    </xsl:template>

</xsl:stylesheet>
