<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xd xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="* | @* | text()">       
        
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>       
        
    </xsl:template>
    
    <xsl:template match="t:text" /> 
    
    <xsl:template match="t:zone/@rendition"/>
    
    <xsl:template match="t:facsimile">
        <xsl:element name="sourceDoc">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="t:zone">
        <xsl:for-each select="./t:zone">
            <xsl:variable name="id" select="@xml:id"/>
            <xsl:variable name="line_text" select="//t:ab[@facs=concat('#', $id)]"/>
            <line>
                <xsl:apply-templates select="@*"/>
                <xsl:choose>
                    <xsl:when test="//t:ab[@facs=concat('#', $id)]/@type = 'textline'">
                        <xsl:attribute name="rendition">
                            <xsl:text>textline</xsl:text>
                        </xsl:attribute>
                        <xsl:for-each select="//t:ab[@facs=concat('#', $id)]/t:w">
                            <xsl:copy>
                                <xsl:apply-templates select="* | @* | text()"/>
                            </xsl:copy>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="rendition">
                            <xsl:value-of select="$line_text/parent::t:gloss/@rendition"/>
                        </xsl:attribute>
                        <xsl:copy-of select="$line_text/text()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </line>
        </xsl:for-each>
    </xsl:template>

<!--    <xsl:template match="t:zone/t:zone">
        <xsl:variable name="id" select="@xml:id"/>
        <xsl:element name="line">

            <xsl:apply-templates select="//t:ab[@facs='$id']/text()"/>
            <xsl:apply-templates select="* | @*"/>
        </xsl:element>
    </xsl:template>-->
    
</xsl:stylesheet>