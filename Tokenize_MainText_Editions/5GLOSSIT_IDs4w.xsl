<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="* | @*" mode="step5">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()" mode="step5"/>
        </xsl:copy>
    </xsl:template>
    
<!--    Set xml:ids for <pc> and <w>-->
    <xsl:template match="t:ab[@ana='#line']/*[not(@xml:id)]" mode="step5">
        <xsl:variable name="line" select="parent::t:ab/@xml:id"/>
        <xsl:copy>           
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat($line, '_', (position()-2))"/>            
            </xsl:attribute>            
            <xsl:apply-templates select="@*|node()"/>           
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:head/*[not(@xml:id)]" mode="step5">
        <xsl:variable name="line" select="parent::t:head/@xml:id"/>
        <xsl:copy>           
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat($line, '_', (position()-1))"/>            
            </xsl:attribute>            
            <xsl:apply-templates select="@*|node()"/>           
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>
