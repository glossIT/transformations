<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template  match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates  select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="t:gloss" >
        <xsl:choose>
            <xsl:when test="child::t:gloss">
                <xsl:variable name="type">
                    <xsl:choose>
                        <xsl:when test="child::t:gloss[1][@type[contains(.,'sign')]]">
                            <xsl:value-of select="child::t:gloss[2]/@type"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="child::t:gloss[1]/@type"/>
                        </xsl:otherwise>
                    </xsl:choose>                   
                </xsl:variable>
                <xsl:variable name="n-number" select="child::t:gloss[1]/@n"/>
                <xsl:copy>
                    <xsl:attribute name="rendition" select="$type"/>
                    <xsl:attribute name="n" select="$n-number"/>
                    <xsl:apply-templates select="./* | @* | text()"/>              
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates  select="* | @* | text()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="t:gloss/t:gloss/@n"/>
    
    <xsl:template match="t:gloss/t:gloss[not(contains(@type, 'sign'))]">
        <xsl:variable name="facs" select="@facs"/>
        <lb facs="{$facs}"/><xsl:value-of select="."/>
    </xsl:template>  

</xsl:stylesheet>
