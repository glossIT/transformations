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

    <xsl:template match="t:pb">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:choose>
                    <xsl:when test="following::t:fw[@type='folio-number']">
                        <xsl:variable name="following-folio-number">
                            <xsl:value-of select="following::t:fw[1]"/>
                        </xsl:variable>
                        <xsl:variable name="preceding-folio-number">
                            <xsl:value-of select="preceding::t:fw[1]"/>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="following::t:pb[1] &lt;&lt; following::t:fw[1]"> <!--Checking whether another page/folionumber or a pb comes first-->
                                <xsl:value-of select="concat($preceding-folio-number, 'v')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat($following-folio-number, 'r')"/>
                            </xsl:otherwise>
                        </xsl:choose>                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="following::t:fw[1]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="t:gloss[@type = 'gloss']">
<!--        THIS IS SINGLE-COLUMN MANUSCRIPTS;-->
        <xsl:copy>
            <xsl:variable name="manuscript">
                <xsl:value-of select="//t:msIdentifier/t:idno"/>
            </xsl:variable>
            <xsl:variable name="pf-number">
                <xsl:choose>
                    <xsl:when test="following::t:fw[@type='folio-number']">
                        <xsl:variable name="following-folio-number">
                            <xsl:value-of select="following::t:fw[1]"/>
                        </xsl:variable>
                        <xsl:variable name="preceding-folio-number">
                            <xsl:value-of select="preceding::t:fw[1]"/>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="following::t:pb[1] &lt;&lt; following::t:fw[1]">
                                <xsl:value-of select="concat($preceding-folio-number, 'v')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat($following-folio-number, 'r')"/>
                            </xsl:otherwise>
                        </xsl:choose>                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="following::t:fw[1]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="ancestor::t:ab[@type = 'MainZone']">
                    <xsl:attribute name="xml:id">                        
                        <xsl:variable name="line-number">
                            <xsl:value-of select="following::t:ab[@type = 'textline'][1]/@n"/>
                        </xsl:variable>
                        <xsl:variable name="gloss-in-line">
                            <xsl:number count="t:gloss" level="any" from="t:ab"/>
                        </xsl:variable>
                        <xsl:value-of select="concat($manuscript, '_', $pf-number, '.', $line-number)"/>
                        <xsl:if test="following-sibling::*[1][self::t:gloss]">
                            <xsl:value-of select="concat('.', $gloss-in-line)"/>
                        </xsl:if>
                        <xsl:if test="$gloss-in-line > 1">
                            <xsl:value-of select="concat('.', $gloss-in-line)"/>
                        </xsl:if>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise> <!--This is for marginal glosses-->
                    <xsl:variable name="marginal-gloss-number">
                        <xsl:number count="t:gloss" level="any" from="t:ab"/>
                    </xsl:variable>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="concat($manuscript, '_', $pf-number, $marginal-gloss-number)"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
