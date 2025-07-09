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
          
    <!--    Here starts the numbering of the glosses-->
    <xsl:template match="t:gloss[@type = 'gloss']">
        <!--        THIS IS SINGLE-COLUMN MANUSCRIPTS;-->
        <xsl:copy>
            <xsl:variable name="manuscript">
                <xsl:value-of select="//t:msIdentifier/t:idno"/>
            </xsl:variable>
            <xsl:variable name="pf-number">
                <xsl:value-of select="substring-after(preceding::t:pb[1]/@n, ' ')"/>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="ancestor::t:ab[@type = 'MainZone']">
                    <xsl:attribute name="xml:id">
                        <xsl:variable name="line-number">
                            <xsl:value-of select="following::t:ab[@type = 'textline'][1]/@n"/>
                        </xsl:variable>
                        <xsl:variable name="gloss-in-line">
                            <xsl:number count="t:gloss[@type = 'gloss']" level="any" from="t:ab"/>
                        </xsl:variable>
                        <xsl:value-of
                            select="concat($manuscript, '_', $pf-number, '_', $line-number)"/>
                        <xsl:if test="following-sibling::*[1][self::t:gloss] or $gloss-in-line > 1">
                            <xsl:value-of select="concat('.', $gloss-in-line)"/>
                        </xsl:if>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <!--This is for marginal and intercolumnar glosses-->
                    <xsl:variable name="marginal-gloss-number">
                        <xsl:number count="t:gloss" level="any" from="t:ab"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:outer']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'mo.', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:inner']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'mi_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:upper']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'mu_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:lower']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'ml_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'ic_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:otherwise>
            </xsl:choose>

            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>


<!--Change the @type of the glosses to interlinear, intercolumnar and marginal-->
    <xsl:template match="t:gloss[@type='gloss']/@type">
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
            <xsl:otherwise>
                <xsl:attribute name="type">
                    <xsl:text>marginal_gloss</xsl:text>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
