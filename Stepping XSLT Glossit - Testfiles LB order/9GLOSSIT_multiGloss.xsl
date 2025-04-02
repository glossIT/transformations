<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template mode="step7" match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates mode="step7" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:multiGloss" mode="step7">
        <xsl:value-of select="t:text[not(preceding-sibling::t:anchor)]"/> <!-- in General davor --> 
        <xsl:for-each select="t:anchor[@type='start']">            
            <seg n="{@n}" corresp="{@n}"><xsl:value-of select="following-sibling::t:text[1]"/></seg>
            <xsl:if test="@n = following-sibling::t:anchor/@type">
                <xsl:value-of select="following-sibling::t:anchor[1]/following-sibling::t:text[1]"/>
            </xsl:if>
        </xsl:for-each>        
    </xsl:template>
</xsl:stylesheet>