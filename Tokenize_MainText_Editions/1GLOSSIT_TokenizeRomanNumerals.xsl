<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    
    <!-- Identity transform to copy all elements and attributes -->
    
    <xsl:template match="@*|node()" mode="#all">        
        <xsl:copy>            
            <xsl:apply-templates select="@*|node()"/>           
        </xsl:copy>       
    </xsl:template>
    
    
    <!-- Replace Roman numerals with <w>NUMERAL<w> -->
    
    <xsl:template match="t:ab/text()">
        <xsl:variable name="linenumber" select="@xml:id"/>
        
        <xsl:analyze-string select="." regex="\.\w+\.">            
            <xsl:matching-substring>               
                <w>
                    <xsl:value-of select="."/>
                </w>
            </xsl:matching-substring>           
            <xsl:non-matching-substring>              
                <xsl:value-of select="."/>              
            </xsl:non-matching-substring>           
        </xsl:analyze-string>

        
    </xsl:template>
    
    <xsl:template match="t:head/text()">
        <xsl:variable name="linenumber" select="@xml:id"/>
        
        <xsl:analyze-string select="." regex="\w+\.">            
            <xsl:matching-substring>               
                <w>
                    <xsl:value-of select="."/>
                </w>
            </xsl:matching-substring>           
            <xsl:non-matching-substring>              
                <xsl:value-of select="."/>              
            </xsl:non-matching-substring>           
        </xsl:analyze-string>
        
        
    </xsl:template>
    
</xsl:stylesheet>