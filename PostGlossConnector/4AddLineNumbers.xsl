<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
    ToDo work Chapter Div in 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xd:doc>
        <xd:desc>copies all the data</xd:desc>
    </xd:doc>
    <xsl:template match="* | @*">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xd:doc>
        <xd:desc>Here we create the line numbers for textlines</xd:desc>
    </xd:doc>
    <xsl:template match="t:ab[@type = 'textline']">
        <xsl:variable name="folio" select="substring-after(preceding::t:pb[1]/@n, '. ')"/>
        <xsl:variable name="line" select="count(preceding-sibling::t:ab[@type = 'textline'])+1"/>
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="concat($folio, '_', $line)"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
