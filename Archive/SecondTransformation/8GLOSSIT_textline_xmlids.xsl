<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="* | @*" >
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates  select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    <!--    Update @ns for textlines, they are counted for each page -->
    <xsl:template match="t:ab[@type='textline']" >
        <xsl:variable name="chapter" select="ancestor::t:div[@type='chapter']/@xml:id"/>
        <xsl:variable name="folio" select="substring-after(preceding::t:pb[1]/@n, ' ')"/>
        <xsl:variable name="line" select="@n"/>
<xsl:copy>        <xsl:attribute name="xml:id">
            <xsl:value-of select="concat($chapter, '_', $folio, '_', $line)"/>
        </xsl:attribute>
        <xsl:apply-templates select="@*|node()" />  </xsl:copy>    
    </xsl:template>

    
</xsl:stylesheet>