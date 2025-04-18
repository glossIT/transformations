<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template mode="step5" match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates mode="step5" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="t:ab[@type!='textline']" mode="step5">
        <ab type="{./@type}">       
            <xsl:apply-templates select="child::node()">
                <xsl:sort select="child::t:lb/@n" data-type="number" order="ascending"/>
            </xsl:apply-templates>
           </ab>
    </xsl:template>
    
    <xsl:template match="t:gloss">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="t:ab[@type='textline']">
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>