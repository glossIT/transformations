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
    <xsl:template match="* | @*" mode="step3">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates mode="step3" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="t:zone[@rendition = 'TextLine']" mode="step3"><zone n="{position()}" rendition="">
           
        </zone>
    </xsl:template>
    <!-- <xsl:template match="t:lb" mode="step3">
        <xsl:copy>            
            <xsl:for-each select=".">
                <xsl:attribute name="facs" select="@facs"/>
                <xsl:attribute name="n">
                    <xsl:variable select="substring-after(./@facs, '#')" name="line"/>
                    <xsl:value-of select="//t:zone[@xml:id = $line]/@n"/>
                </xsl:attribute>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>-->
</xsl:stylesheet>
