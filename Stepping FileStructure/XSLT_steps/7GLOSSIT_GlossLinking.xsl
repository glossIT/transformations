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
    <!--    Here starts the numbering of the glosses-->
    <xsl:template match="t:seg" mode="step7">    
            <xsl:if test="./@corresp">       
            <xsl:variable name="segID">
                <xsl:value-of select="./@corresp"/>
            </xsl:variable>
            <xsl:variable name="glossID">
                <xsl:value-of select="preceding::t:gloss[@n = $segID][1]/@n"/>
            </xsl:variable>
                <seg>
                    <xsl:if test="$segID = $glossID">
                        <xsl:attribute name="corresp">
                            <xsl:value-of select="preceding::t:gloss[@n = $segID][1]/@xml:id"/>
                        </xsl:attribute>
                    </xsl:if>
            <xsl:value-of select ="."></xsl:value-of></seg>
            </xsl:if>
          
    </xsl:template>
    <xsl:template match="t:gloss/text()" mode="step7">
        <xsl:analyze-string select="." regex="\$\d+\$"> 
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
</xsl:stylesheet>