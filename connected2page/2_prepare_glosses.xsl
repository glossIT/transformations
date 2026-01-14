<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl xd" version="2.0">
    
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
        <xd:desc>Here we are creating w on each whitespace</xd:desc>
    </xd:doc>
    <xsl:template match="t:ab[@ana='#glossline']">
        <xsl:for-each select="tokenize(text(), ' ')">
            <w><xsl:value-of select="."/></w>
        </xsl:for-each>
    </xsl:template>   
    
    <xd:doc>
        <xd:desc>Here we are adding the attributes to the glosses</xd:desc>
    </xd:doc>
    
    <xsl:template match="t:gloss">
        <gloss rendition="{@rendition}" target="{@target}" xml:id="{@xml:id}">
            <xsl:attribute name="ana"/>
            <xsl:attribute name="type"/>
            <xsl:attribute name="subtype"/>
            <xsl:apply-templates/>  
            <note type="translation"></note>
            <note type="glossing"></note>
            <note type="comments"></note>     
        </gloss>
    </xsl:template>
    
</xsl:stylesheet>