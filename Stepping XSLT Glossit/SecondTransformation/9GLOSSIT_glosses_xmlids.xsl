<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <!--    Update @ns for textlines, they are counted for each page -->
    <xsl:template match="t:gloss">
        <xsl:variable name="line" select="preceding::t:ab[@type = 'textline'][1]/@xml:id"/>
        <xsl:variable name="gloss">
            <xsl:number count="t:gloss"/>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat($line, '_', $gloss)"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
