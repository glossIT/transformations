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
    
    <xsl:template match="* | @*">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!--    Tokenize on whitespaces-->
    <xsl:template match="t:ab[@type='textline']/text() | t:gloss/text()">
        <xsl:apply-templates select="* | @*"/>        
        <xsl:for-each select="tokenize(., '\s')">
            <w>
                <xsl:value-of select="."/>                   
            </w>
        </xsl:for-each>
    </xsl:template>
    
<!--Problem mit mehrzeiligen glossen - da geht was komisches ab mit dem for-each, zur zeit in der nächsten trans
    formation abgefangen-->

    
</xsl:stylesheet>
