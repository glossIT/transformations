<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template mode="step8" match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates mode="step8" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    <!--    Here signes de renvoi are changed to pointers-->
    <xsl:template match="t:gloss[@type = 'signe_de_renvoi']" mode="step8">
        <xsl:variable name="facs" select="child::t:lb/@facs"/>
        <xsl:variable name="rend" select="."/>
        <ptr type="signe_de_renvoi" facs="{$facs}" rendition="{$rend}"/>
    </xsl:template>
 
    <xsl:template match="t:gloss[not(@type = 'signe_de_renvoi')]" mode="step8">
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
                            <xsl:variable name="preceding_not_gloss_element" select="generate-id(preceding-sibling::*[not(self::t:gloss)][1])"/>
                            <xsl:if test="following-sibling::t:gloss[1] and not(preceding-sibling::t:gloss[1])">
                                <xsl:text>_1</xsl:text>
                            </xsl:if>
                            <xsl:if test="preceding-sibling::t:gloss[1]">
                                <xsl:value-of select="concat('_', count(preceding-sibling::t:gloss[not(@type = 'signe_de_renvoi')][generate-id(preceding-sibling::*[not(self::t:gloss)][1]) = $preceding_not_gloss_element][following-sibling::t:gloss[1]]) + 1)"/>
                            </xsl:if>
                        </xsl:variable>
                        <xsl:value-of select="concat($manuscript, '_', $pf-number, '_', $line-number, $gloss-in-line)"/>
                    </xsl:attribute>
                </xsl:when>
                
                <xsl:when test="ancestor::t:ab[@type = 'MainZone:column_right'] or ancestor::t:ab[@type = 'MainZone:column_left']">
                    <xsl:attribute name="xml:id">
                        <xsl:variable name="column">
                            <xsl:choose>
                                <xsl:when test="ancestor::t:ab[@type = 'MainZone:column_right']">
                                    <xsl:text>cr</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>cl</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="line-number">
                            <xsl:value-of select="following::t:ab[@type = 'textline'][1]/@n"/>
                        </xsl:variable>
                        <xsl:variable name="gloss-in-line">
                            <xsl:variable name="preceding_not_gloss_element" select="generate-id(preceding-sibling::*[not(self::t:gloss)][1])"/>
                            <xsl:if test="following-sibling::t:gloss[1] and not(preceding-sibling::t:gloss[1])">
                                <xsl:text>_1</xsl:text>
                            </xsl:if>
                            <xsl:if test="preceding-sibling::t:gloss[1]">
                                <xsl:value-of select="concat('_', count(preceding-sibling::t:gloss[not(@type = 'signe_de_renvoi')][generate-id(preceding-sibling::*[not(self::t:gloss)][1]) = $preceding_not_gloss_element][following-sibling::t:gloss[1]]) + 1)"/>
                            </xsl:if>
                        </xsl:variable>
                        <xsl:value-of select="concat($manuscript, '_', $pf-number, '_', $column, '_', $line-number, $gloss-in-line)"/>
                    </xsl:attribute>
                </xsl:when>
                
                <xsl:otherwise>
                    <!--                    <!-\\-This is for marginal and intercolumnar glosses-\\->-->
                    <xsl:variable name="marginal-gloss-number">
                        <xsl:if test="not(preceding-sibling::t:gloss[not(@type = 'signe_de_renvoi')])">
                            <xsl:text>1</xsl:text>
                        </xsl:if>
                        <xsl:if test="preceding-sibling::t:gloss[not(@type = 'signe_de_renvoi')]">
                            <xsl:value-of select="count(preceding-sibling::t:gloss[not(@type = 'signe_de_renvoi')]) + 1"/>
                        </xsl:if>
                    </xsl:variable>
                    <xsl:variable name="line-number">
                        <xsl:value-of select="following::t:ab[@type = 'textline'][1]/@n"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:outer']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="concat($manuscript, '_', $pf-number, '_mo_', $marginal-gloss-number)"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:inner']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="concat($manuscript, '_', $pf-number, '_mi_', $marginal-gloss-number)"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:upper']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="concat($manuscript, '_', $pf-number, '_mu_', $marginal-gloss-number)"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:lower']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="concat($manuscript, '_', $pf-number, '_ml_', $marginal-gloss-number)"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="concat($manuscript, '_', $pf-number, '_ic_', $marginal-gloss-number)"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:apply-templates select="* | @* | text()" mode="step8"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
