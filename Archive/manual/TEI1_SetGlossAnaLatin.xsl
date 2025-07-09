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

    <xsl:template match="* | @* | text()">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates select="* | @*[normalize-space()] | text()"/>
        </xsl:copy>
    </xsl:template>


<!--    All glosses that are not signes de renvois and do not have any ana-language-attribute 
    are per default Latin and therefore set as such
-->    
    
    <xsl:template match="t:gloss[not(@type = 'signe_de_renvoi') and not(./@ana)]">
        <xsl:copy>
            <xsl:attribute name="ana">
                <xsl:text>#la</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
