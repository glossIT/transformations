<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="text" encoding="utf-8"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="t:body">
        <xsl:text>
            "Folio", "Gloss", "Glossing" &#xD;
        </xsl:text>
        <xsl:apply-templates />
               
    </xsl:template>
    
    <xsl:template match="t:pb"/>
    
    <xsl:template match="t:ab"/>
    
    <xsl:template match="t:gloss">
        <xsl:variable name="page">
            <xsl:value-of select="preceding::t:pb[1]/@n"/>
        </xsl:variable>
        <xsl:variable name="target">
            <xsl:value-of select="substring-after(@target, '#')"/>
        </xsl:variable>
        <xsl:variable name="glossing">
            <xsl:value-of select="//t:ab/t:w[@xml:id=$target]"/>
        </xsl:variable>
        <xsl:if test="position() != last()">"<xsl:value-of select="$page"/>", "<xsl:value-of select="normalize-space(.)"/>", "<xsl:value-of select="normalize-space($glossing)"/>" <xsl:text>&#xa;</xsl:text>
        </xsl:if>
        <xsl:if test="position()  = last()">"<xsl:value-of select="$page"/>", "<xsl:value-of select="normalize-space(.)"/>", "<xsl:value-of select="normalize-space($glossing)"/>" <xsl:text>&#xD;</xsl:text>
            </xsl:if>
    </xsl:template>
    
    <xsl:template match="t:fw"/>
    
    <xsl:template match="t:teiHeader"/>
    
</xsl:stylesheet>
