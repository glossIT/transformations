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
    
    <xsl:template mode="step4" match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates mode="step4" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    <!--    Reordering the t:lbs according to the coordinates of their corresponding zones-->
    <!--<xsl:template match="t:ab[@type!='textline']" mode="step4">
        <ab type="{./@type}">
        <xsl:copy>                   
            <xsl:apply-templates>
                <xsl:sort
                    select="./t:lb/@n"
                    data-type="number" order="ascending"/>
            </xsl:apply-templates>
        </xsl:copy>
        </ab>
    </xsl:template>
    -->
    <xsl:template match="t:lb" mode="step4">
         <xsl:for-each select="self::t:lb">
             <lb facs="{./@facs}">                      
                <xsl:attribute name="n">
                    <xsl:variable select="substring-after(./@facs, '#')" name="line"/>
                    <xsl:value-of select="//t:zone[@xml:id=$line]/@n"/>
                </xsl:attribute></lb>
            </xsl:for-each>
     
    </xsl:template>
  
</xsl:stylesheet>