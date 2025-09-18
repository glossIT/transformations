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
    
    <xsl:template match="@*|node()" mode="step4">        
        <xsl:copy>            
            <xsl:apply-templates select="@*|node()" mode="step4"/>           
        </xsl:copy>       
    </xsl:template>
    
    
    <!-- Remove empty <w>s -->
    
    <xsl:template match="t:w[not(node())]" mode="step4"/>
    
</xsl:stylesheet>