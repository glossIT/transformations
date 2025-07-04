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
    
    <!--    Set @xml:ids for each t:w-->
    <xsl:template match="t:w">
        <xsl:variable name="id">
            <xsl:variable name="w">
                <xsl:number count="t:w"/>
            </xsl:variable>
            <xsl:choose>
            <xsl:when test="parent::t:ab">
                <xsl:variable name="line" select="parent::t:ab/@xml:id"/>               
                <xsl:value-of select="concat($line, '_', $w)"/>
            </xsl:when>
            <xsl:when test="parent::t:gloss">
                <xsl:variable name="line" select="parent::t:gloss/@xml:id"/>
                <xsl:value-of select="concat($line, '_', $w)"/>
            </xsl:when>
        </xsl:choose>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="$id"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
<!--    Deletes the empty t:w created in the previous transformation -> check this!-->
    <xsl:template match="t:w[not(node())]" />
    
</xsl:stylesheet>
