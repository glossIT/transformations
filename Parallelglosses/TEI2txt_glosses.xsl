<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer 
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->

<!--This transformation takes GlossIT-TEIs as input and extracts the glosses as .txt-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl"
    version="2.0">
    
    <xsl:output method="text" encoding="utf-8" />
    
<!--    <xsl:param name="delim" select="','" />
    <xsl:param name="quote" select="'&quot;'" />-->
    <xsl:param name="break" select="'&#xA;'" />
    
    <xsl:template match="/">
        <xsl:apply-templates select="//t:ab/t:gloss" />
    </xsl:template>
    
    <xsl:template match="t:gloss[@xml:id]">
<!--        <xsl:variable name="gloss_id" select="@xml:id"/>
        <xsl:value-of select="concat($quote, $gloss_id, $quote)"/>
        <xsl:value-of select="$delim"/>-->
        <xsl:value-of select="normalize-space()" />
        <xsl:if test="following::*">
            <xsl:value-of select="$break" />
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="text()" />
    
</xsl:stylesheet>