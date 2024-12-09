<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template mode="step6" match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates mode="step6" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="t:gloss[@type = 'gloss']" mode="step6">
        <!--        THIS IS SINGLE-COLUMN MANUSCRIPTS;-->
        <gloss>
            <xsl:variable name="manuscript">
                <xsl:value-of select="//t:msIdentifier/t:idno"/>
            </xsl:variable>
            <xsl:variable name="pf-number">
                <xsl:value-of select="substring-after(preceding::t:pb[1]/@n, ' ')"/>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="ancestor::t:ab[@type = 'MainZone']">
                    <xsl:attribute name="type">
                        <xsl:text>interlinear_gloss</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="ancestor::t:ab[@type = 'Intercolumnar']">
                    <xsl:attribute name="type">
                        <xsl:text>intercolumnar_gloss</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="ancestor::t:ab[@type = 'MainZone:column_right'] or ancestor::t:ab[@type = 'MainZone:column_left']">
                    <xsl:attribute name="type">
                        <xsl:text>interlinear_gloss</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="type">
                        <xsl:text>marginal_gloss</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <lb facs="{./t:lb/@facs}" n="{./t:lb/@n}"/>
            <xsl:value-of select="."/>
        </gloss>
    </xsl:template>

<!--    Here the textlines are counted and get a n-attribute-->
    <xsl:template match="t:ab[@type = 'textline']" mode="step6">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:number count="t:ab[@type = 'textline']" level="any" from="t:ab[not(@type = 'textline')]"/>
            </xsl:attribute>
            <xsl:apply-templates mode="step6" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
