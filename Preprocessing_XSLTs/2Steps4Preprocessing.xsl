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
    
    <xsl:template match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
<!--    Set @ns for textlines and glosses in the body-->
    <xsl:template match="t:ab[@type='textline']" >
           <xsl:copy>                
               <xsl:attribute name="n">
                    <xsl:variable select="substring-after(./@facs, '#')" name="line"/>
                    <xsl:value-of select="//t:zone[@xml:id=$line]/@n"/>
                </xsl:attribute>
                <xsl:apply-templates select="@*|node()"/>  
            </xsl:copy>       
    </xsl:template>
    
    <xsl:template match="t:gloss" >
        <xsl:copy>                
            <xsl:attribute name="n">
                <xsl:variable select="substring-after(./@facs, '#')" name="line"/>
                <xsl:value-of select="//t:zone[@xml:id=$line]/@n"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>  
        </xsl:copy>        
    </xsl:template>
    
</xsl:stylesheet>