<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template mode="step7" match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates mode="step7" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="t:gloss" mode="step7">
        <xsl:choose>
            <xsl:when test="child::t:gloss">
                <xsl:variable name="type">
                    <xsl:choose>
                        <xsl:when test="child::t:gloss[1][@type='signe_de_renvoi']">
                            <xsl:value-of select="child::t:gloss[2]/@type"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="child::t:gloss[1]/@type"/>
                        </xsl:otherwise>
                    </xsl:choose>                   
                </xsl:variable>
                <xsl:copy>
                    <xsl:attribute name="type" select="$type"/>
                    <xsl:apply-templates select="child::t:gloss[@type='signe_de_renvoi']" mode="step7"/>
                    <xsl:copy-of select="child::t:gloss[@type!='signe_de_renvoi']/* | child::t:gloss[@type!='signe_de_renvoi']/text()"/>                   
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates mode="step7" select="* | @* | text()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
