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
    <xsl:strip-space elements="*"/>
    <xsl:template match="* | @*" mode="step2">
        <xsl:copy>
            <xsl:apply-templates mode="step2" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="t:pb[@n = 'p. ']/@n" mode="step2">
        <xsl:attribute name="n">
            <xsl:value-of select="concat(substring-before(preceding::t:pb[1]/@n, 'r'), 'v')"/>
        </xsl:attribute>
    </xsl:template>
    <!--    Ordering of the lines inside of Regions -->
    <xsl:template match="t:zone[@rendition = 'TextRegion']" mode="step2">
        <zone rendition="{@rendition}" points="{@points}" rotate="{@rotate}" xml:id="{@xml:id}">
            <xsl:apply-templates>
                <xsl:sort
                    select="substring-after(substring-after(substring-after(substring-after(./@points, ','), ','), ','), ',')"
                    data-type="number" order="ascending"/>
            </xsl:apply-templates>
        </zone>
    </xsl:template>
    <xsl:template match="t:zone[@rendition = 'TextLine']">
        <!--<xsl:variable name="sum">
            <xsl:value-of select="count(.)"/>
        </xsl:variable>-->
        <zone points="{./@points}" rendition="{./@rendition}" rotate="{./@rotate}"
            xml:id="{./@xml:id}"/>
        
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template> 
</xsl:stylesheet>