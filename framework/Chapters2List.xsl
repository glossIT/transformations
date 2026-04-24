<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case:
    This prepare the given pageXML for the next step.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" version="3.0">
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xd:doc>
        <xd:desc>Entry point: start at the top of the work xml</xd:desc>
    </xd:doc>
    
    <xsl:template match="/t:TEI">
        <TEI>   <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Title</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Information about publication or distribution</p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Information about the source</p>
                    </sourceDesc>
                </fileDesc>
        </teiHeader><text>        <body><list>
            <xsl:for-each select="//t:div[@type='chapter']">                
                <item><xsl:attribute name="n"><xsl:value-of select="@n"/></xsl:attribute><xsl:value-of select="child::t:head"/></item>
            </xsl:for-each>
        </list></body></text></TEI>
    </xsl:template>
    
</xsl:stylesheet>