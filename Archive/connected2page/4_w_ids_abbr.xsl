<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl xd" version="2.0">

    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xd:doc>
        <xd:desc>copies all the data</xd:desc>
    </xd:doc>
    <xsl:template match="* | @*">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xd:doc>
        <xd:desc>Here we expand the abbreviations</xd:desc>
    </xd:doc>

    <xsl:template match="t:ab[@ana = '#glossline']//t:abbr">
        <choice>
            <abbr>
                <xsl:value-of select="."/>
            </abbr>
            <expan>
                <xsl:value-of select="@corresp"/>
            </expan>
        </choice>
    </xsl:template>

    <xd:doc>
        <xd:desc>Here we add corrected readings to sic</xd:desc>
    </xd:doc>

    <xsl:template match="t:ab[@ana = '#glossline']//t:sic">
        <choice>
            <xsl:copy>
                <xsl:apply-templates/>
            </xsl:copy>
            <corr>
                <xsl:value-of select="@ana"/>
            </corr>
        </choice>
    </xsl:template>

    <xd:doc>
        <xd:desc>Here we add IDs to the w of glosses</xd:desc>
    </xd:doc>

    <xsl:template match="t:ab[@ana = '#glossline']/t:w">
        <xsl:variable name="line" select="parent::t:ab/@facs"/>
        <xsl:variable name="wordnumber" select="count(preceding-sibling::t:w)"/>
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat($line, '_word_', $wordnumber)"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
