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
    
    <!--    Adding the n of the textline (of the zone) to the corresponding t:lb-->
    <xsl:template match="t:lb">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:for-each select="self::t:lb">
                <xsl:attribute name="n">
                    <xsl:variable select="substring-after(@facs, '#')" name="line"/>
                    <xsl:value-of select="//t:zone[@xml:id=$line]/@n"/>
                </xsl:attribute>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>