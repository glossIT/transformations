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
    <xsl:template match="t:div[@type = 'page']">
        <xsl:variable name="page" select="substring-after(child::t:pb/@n, ' ')"/>
        <xsl:result-document href="{concat($page, '.xml')}">
            <TEI xmlns="http://www.tei-c.org/ns/1.0" rendition="glossit"><xsl:for-each select=".">
                <xsl:copy-of select="//t:teiHeader"/>
                <xsl:copy-of select="//t:facsimile"/>
                <body><xsl:copy-of select="."/></body>
            </xsl:for-each></TEI>


        </xsl:result-document>
    </xsl:template>


</xsl:stylesheet>
