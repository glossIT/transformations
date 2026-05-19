<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case:
    This prepare the given pageXML for the next step.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xd:doc>
        <xd:desc>Entry point: start at the top of the chapter list</xd:desc>
    </xd:doc>

    <xsl:template match="/t:TEI">
        <xsl:for-each select="//t:div2">
            <xsl:variable name="filename" select="concat('Kas4_', @n)"/>
            <!--Update filename-->
<!--            <xsl:variable name="file" select="document('Kas4_connected_chapter_divs')"/>
            <!-\-Update filename-\->-->
            <xsl:result-document href="./chapters/{$filename}.xml">
                <TEI xmlns="http://www.tei-c.org/ns/1.0" rendition="glossit">

                        <xsl:copy-of select="//t:teiHeader"/>

                        <xsl:copy-of select="//t:facsimile"/>
                    <xsl:text>
            </xsl:text>
                    <text>
                        <xsl:text>
            </xsl:text>

                        <body>
                            <xsl:variable name="div1" select="parent::t:div1/@n"/>
                            <xsl:variable name="div2" select="@n"/>
                            <div1 n="{$div1}">
                                <div2 n="{$div2}"><xsl:copy-of select="*"/></div2>
                            </div1>
                        </body>

                    </text>
                    <xsl:text>
            </xsl:text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>


</xsl:stylesheet>
