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

    <!--    Finding and replacing abbreviations in the glosses -->
    <!--    <xsl:template match="t:gloss">
        <xsl:copy>        
            <xsl:apply-templates select="*" mode="glosses"/>
        </xsl:copy>
    </xsl:template> -->

    <xsl:template match="t:gloss/text()">
<!--        <xsl:analyze-string select="." regex="ꝓ">
            <xsl:matching-substring>
                <choice>
                    <abbrev>ꝓ</abbrev>
                    <expan>pro</expan>
                </choice>
            </xsl:matching-substring>
        </xsl:analyze-string>
        <xsl:analyze-string select="." regex="ł$">
            <xsl:matching-substring>
                <choice>
                    <abbrev>ł</abbrev>
                    <expan>uel</expan>
                </choice>
            </xsl:matching-substring>
        </xsl:analyze-string>-->
        <xsl:analyze-string select="." regex=".̃$">
            <xsl:matching-substring>
                <xsl:variable name="string">
                    <xsl:value-of select="."/>
                </xsl:variable>
                <choice>
                    <abbrev>
                        <xsl:value-of select="$string"/>
                    </abbrev>
                    <expan><xsl:value-of select="substring-before($string, '̃')"/>m</expan>
                </choice>
<!--                <xsl:choose>
                    <xsl:when test="contains($string, 'u')">
                        <choice>
                            <abbrev>
                                <xsl:value-of select="$string"/>
                            </abbrev>
                            <expan><xsl:value-of select="substring-before($string, '̃')"/>m</expan>
                        </choice>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy/>
                    </xsl:otherwise>
                </xsl:choose>
-->
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:copy/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>



</xsl:stylesheet>
