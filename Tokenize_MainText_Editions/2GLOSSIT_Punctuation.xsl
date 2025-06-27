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
    
    <xsl:template match="@*|node()">        
        <xsl:copy>            
            <xsl:apply-templates select="@*|node()"/>           
        </xsl:copy>       
    </xsl:template>
    
    
    <!-- Replace punctuation in text nodes with <pc>§</pc> -->
    
    <xsl:template match="t:ab/text()">
        <xsl:variable name="linenumber" select="@xml:id"/>
               
        <xsl:analyze-string select="." regex="[^\w\s]+">            
            <xsl:matching-substring>               
                <xsl:choose>
                    <xsl:when test=". = ','">
                        <pc>,</pc>
                    </xsl:when>
                    <xsl:when test=". = '.'">
                        <pc>.</pc>
                    </xsl:when>
                    <xsl:when test=". = ';'">
                        <pc>;</pc>
                    </xsl:when>
                    <xsl:when test=". = ':'">
                        <pc>:</pc>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/> 
                    </xsl:otherwise>
                </xsl:choose>
    
            </xsl:matching-substring>           
            <xsl:non-matching-substring>              
                <xsl:value-of select="."/>              
            </xsl:non-matching-substring>           
        </xsl:analyze-string>    
     
    </xsl:template>

</xsl:stylesheet>