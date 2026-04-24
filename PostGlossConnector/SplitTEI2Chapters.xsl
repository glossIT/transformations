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
        <xsl:for-each select="//t:item">
            <xsl:variable name="filename" select="concat('Kas4_', @n)"/>
            <!--Update filename-->
            <xsl:variable name="file" select="document('Kas4_connected.xml')"/>
            <!--Update filename-->
            <xsl:result-document href="./chapters/{$filename}.xml">
                <TEI xmlns="http://www.tei-c.org/ns/1.0" rendition="glossit">
                    <teiHeader xml:lang="en">
                        <xsl:copy-of select="$file//t:teiHeader"/>
                    </teiHeader>
                    <facsimile>
                        <xsl:copy-of select="$file//t:facsimile"/>
                    </facsimile>
                    <xsl:text>
            </xsl:text>
                    <text>
                        <xsl:text>
            </xsl:text>

                        <body/>

                    </text>
                    <xsl:text>
            </xsl:text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>


</xsl:stylesheet>
