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
    
    <!--    Reordering the t:lbs according to the coordinates of their corresponding zones-->
    <xsl:template match="t:ab[@type!='textline']">
        <xsl:copy>        
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="child::node()">
                <xsl:sort select="child::t:lb/@n" data-type="number" order="ascending"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>