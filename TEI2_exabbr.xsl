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

    <xsl:template match="t:gloss[@ana='#la']/text()">
        <xsl:analyze-string select="." regex="[a,e,i,o,u]̃$|[a,e,i,o,u]̃\s|&amp;|ł|ꝰ|ꝓ|ꝑ">
            <xsl:matching-substring>
                <xsl:variable name="string">
                    <xsl:value-of select="."/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="contains($string, 'ꝰ')">
                        <choice>
                            <am>
                                <xsl:value-of select="$string"/>
                            </am>
                            <ex>us</ex>
                        </choice>  
                    </xsl:when>
                    <xsl:when test="contains($string, ' ')">
                        <choice>
                            <am>
                                <xsl:value-of select="substring-before($string, ' ')"/>
                            </am>
                            <ex><xsl:value-of select="substring-before($string, '̃')"/>m</ex>
                        </choice>
                        
                    </xsl:when>
                    <xsl:when test="contains($string, '̃')">
                        <choice>
                            <am>
                                <xsl:value-of select="$string"/>
                            </am>
                            <ex><xsl:value-of select="substring-before($string, '̃')"/>m</ex>
                        </choice>
                    </xsl:when>
                    <xsl:when test="$string = '&amp;'">
                        <choice>
                            <am>
                                <xsl:value-of select="$string"/>
                            </am>
                            <ex>et</ex>
                        </choice>
                    </xsl:when>
                    <xsl:when test="contains($string, 'ł')">
                        <choice>
                            <am>
                                <xsl:value-of select="$string"/>
                            </am>
                            <ex>uel</ex>
                        </choice>                       
                    </xsl:when>
                    <xsl:when test="contains($string, 'ꝰ')">
                        <choice>
                            <am>
                                <xsl:value-of select="$string"/>
                            </am>
                            <ex>us</ex>
                        </choice>  
                    </xsl:when>
                    <xsl:when test="contains($string, 'ꝓ')">
                        <choice>
                            <am>
                                <xsl:value-of select="$string"/>
                            </am>
                            <ex>per</ex>
                        </choice> 
                    </xsl:when>
                    <xsl:when test="contains($string, 'ꝑ')">
                        <choice>
                            <am>
                                <xsl:value-of select="$string"/>
                            </am>
                            <ex>pro</ex>
                        </choice>
                    </xsl:when>
                </xsl:choose>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:copy/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>



</xsl:stylesheet>
