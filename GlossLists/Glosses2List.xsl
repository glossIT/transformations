<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>


    <xsl:template match="* | @*">       
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>


    <xsl:template match="t:div">
                <xsl:for-each select="//t:head">
                    <xsl:variable name="chapter" select="self::t:head"/>
                    <div type="chapter" xml:id="{$chapter}">
                        <xsl:variable name="this_chapter" select="generate-id()"/>
                        <xsl:for-each select="following::t:gloss[@type = 'InterlinearLine:gloss' or @type = 'MarginalLine:gloss'][generate-id(preceding::t:head[1]) = $this_chapter]">
                            <xsl:apply-templates select="."/>
                        </xsl:for-each>
                    </div>
                </xsl:for-each>
    </xsl:template>

    <xsl:template match="t:gloss">
        <xsl:apply-templates />
<!--        <xsl:variable name="folio" select="preceding::t:pb[1]/@n"/>
        <xsl:variable name="chapter" select="preceding::t:head[1]"/>
        <xsl:variable name="gloss_number" select="count(preceding::t:gloss[@type = 'InterlinearLine:gloss' or @type = 'MarginalLine:gloss'])"/>
        <xsl:variable name="id" select="concat(replace($folio, ' ', ''), '-', $gloss_number)"/>
        <xsl:copy>
            <xsl:apply-templates /> 
        </xsl:copy>-->
    </xsl:template>

    <xsl:template match="t:ab"/>

</xsl:stylesheet>
