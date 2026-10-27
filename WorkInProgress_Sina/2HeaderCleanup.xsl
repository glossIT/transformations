<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xd:doc>
        <xd:desc>copies all the data from step 1</xd:desc>
    </xd:doc>
    <xsl:template match="* | @*" mode="step1">       
  
        <xsl:copy>
            <xsl:apply-templates mode="step1" select="* | @* | text()"/>
        </xsl:copy>

    </xsl:template>
    
    <xd:doc>
        <xd:desc>Here we are creating the folio/pagenumbers</xd:desc>
    </xd:doc>
 <xsl:template match="//t:teiHeader" mode="step1"></xsl:template>    
</xsl:stylesheet>