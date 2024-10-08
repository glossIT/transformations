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
    
    <xsl:template match="* | @* | text()">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates select="* | @*[normalize-space()] | text()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="t:pb[@n = 'p. ']/@n">
        <xsl:attribute name="n">
            <xsl:value-of select="concat(substring-before(preceding::t:pb[1]/@n, 'r'), 'v')"/>
        </xsl:attribute>
    </xsl:template>
    
    
<!--    Ordering the zones according to their coordinates, we are taking the final number of the coordinates   -->
    <xsl:template match="t:zone[@rendition = 'TextRegion']">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="t:zone">
                <xsl:sort select="substring-after(substring-after(substring-after(substring-after(@points, ','), ','), ','), ',')" data-type="number" order="ascending"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
<!--    Adding an attribute n to each TextLine which helps to reorder the lbs for each textregion-->
    <xsl:template match="t:zone[@rendition='TextLine']">
        <xsl:copy>        
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="n">
                <xsl:value-of select="position()"/>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>