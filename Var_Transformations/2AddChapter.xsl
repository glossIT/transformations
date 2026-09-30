<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case: Add @ana of the corresponding ms/work/chapter to every zone and line
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xd xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="* | @* | text()">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="t:zone | t:line">
        <xsl:variable name="chapter" select="preceding::t:anchor[1]/@ana"/>
        <xsl:copy>
            <xsl:attribute name="ana">
                <xsl:value-of select="$chapter"/>
            </xsl:attribute>
            <xsl:apply-templates select="*|@*|node()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
