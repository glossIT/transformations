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
    
    <xsl:template match="* | @*" >
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates  select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    <!--    Update @ns for textlines, they are counted for each page -->
    <xsl:template match="t:ab[@type='textline']/@n" >
            <xsl:attribute name="n">
                <xsl:number count="t:ab[@type='textline']"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()" />      
    </xsl:template>
    
    <!--    Remove @ns for glosses-->
    <xsl:template match="t:gloss/@n"/>
    
</xsl:stylesheet>