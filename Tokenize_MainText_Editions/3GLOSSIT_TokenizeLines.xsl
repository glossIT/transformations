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

    <xsl:template match="* | @*" mode="step3">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()" mode="step3"/>
        </xsl:copy>
    </xsl:template>


<!--    Tokenize on whitespaces-->
    <xsl:template match="t:ab/text()" mode="step3">
        <xsl:apply-templates select="* | @*"/>
        
        <xsl:for-each select="tokenize(., '\w+\$|\s')">
            <w>
                <xsl:value-of select="."/>                   
            </w>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="t:head/text()" mode="step3">
        <xsl:apply-templates select="* | @*"/>
        
        <xsl:for-each select="tokenize(., '\w+\$|\s')">
            <w>
                <xsl:value-of select="."/>                   
            </w>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
