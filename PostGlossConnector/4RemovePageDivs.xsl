<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
    ToDo work Chapter Div in 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
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
        <xd:desc>Here we remove the divs for the pages</xd:desc>
    </xd:doc>
    <xsl:template match="t:div[@type='page']">
        <xsl:copy-of select="*"/>
    </xsl:template>
    

</xsl:stylesheet>
