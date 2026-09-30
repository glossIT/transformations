<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case: Copies the value of graphic/@url into a new attribute @ana
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xd xsl" version="2.0">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!-- Identity template - copies everything by default -->
    <xsl:template match="t:graphic">
        <xsl:value-of select="@url"/>
    </xsl:template>
    
    <xsl:template match="t:teiHeader"/>
    
    <xsl:template match="t:zone"/>
    
</xsl:stylesheet>