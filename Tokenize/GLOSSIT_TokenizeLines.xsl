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
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>


    <xsl:template match="t:ab">
        <xsl:variable name="linenumber" select="@xml:id"/>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            
            <xsl:for-each select="tokenize(text(), '\s')">
                <xsl:variable name="word" select="position()"/>
                <xsl:variable name="id" select="concat($linenumber,'_', $word)"/>
                <w xml:id="{$id}">
                    <xsl:value-of select="."/>                   
                </w>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>



</xsl:stylesheet>
