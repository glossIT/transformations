<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case: Sort surfaces/graphics within the sourceDoc in GlossIT-ET-XMLS and removes empty attributes
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xd xsl" version="2.0">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!-- Identity template - copies everything by default -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Re-ordering within the sourceDoc -->
    <xsl:template match="t:sourceDoc">
        <xsl:copy>
            <!-- Copy all attributes -->
            <xsl:apply-templates select="@*"/>
            
            <!-- Sort surfaces by their graphic's url attribute -->
            <xsl:apply-templates select="t:surface">
                <xsl:sort select="t:graphic/@url"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <!-- Remove empty attributes -->
    <xsl:template match="@*[normalize-space(.) = '']"/>
    
</xsl:stylesheet>