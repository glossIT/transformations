<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer
    Company: ZIM-ACDH (Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities)
 -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" >
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:strip-space elements="*"/>
    <xsl:template match="node() | @*">
        <xsl:copy >
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:head">
        <xsl:variable name="Work"> 
            <xsl:text>DNR</xsl:text> <!--Please input the Work manually, i.e. DNR for 'De Natura Rerum', etc.-->
        </xsl:variable>
        <xsl:variable name="header-id" select="generate-id(.)"/>
        <div type="chapter" n="{concat($Work, '_', substring-before(., '.'))}">
            <head>
                <xsl:variable name="ChapterNumber">
                    <xsl:value-of select="substring-before(self::t:head, '.')"/>
                </xsl:variable>
                <xsl:variable name="PageNumber">
                    <xsl:value-of select="preceding::t:pb[1]/@n"/>
                </xsl:variable>
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="concat($Work, '_', $ChapterNumber, '_', $PageNumber, '_1')"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </head>
            <xsl:for-each select="following-sibling::*[generate-id(preceding-sibling::t:head[1]) = $header-id][not(self::t:head)]">
                <xsl:copy>
                    <xsl:apply-templates select="node() | @*"/>
                </xsl:copy>
            </xsl:for-each>             
        </div>
    </xsl:template>
    
    

    <xsl:template match="t:ab[@ana='#line']">
        
        <xsl:variable name="Work"> 
            <xsl:text>DNR</xsl:text> <!--Please input the Work manually, i.e. DNR for 'De Natura Rerum', etc.-->
        </xsl:variable>
        <xsl:variable name="ChapterNumber">
            <xsl:value-of select="substring-before(preceding::t:head[1], '.')"/>
        </xsl:variable>
        <xsl:variable name="PageNumber">
            <xsl:value-of select="preceding::t:pb[1]/@n"/>
        </xsl:variable>
        <xsl:variable name="LineNumber"> <!--This counts the number of lines for each chapter-->
            <xsl:number from="t:head" count="t:ab[@ana='#line']" level="any" />
        </xsl:variable>

        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat($Work, '_', $ChapterNumber, '_', $PageNumber, '_', ($LineNumber+1))"/>
            </xsl:attribute>
            <xsl:attribute name="ana">
                <xsl:text>#line</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:pb" />
    
    <xsl:template match="t:div[@type='Main']"/>

</xsl:stylesheet>
