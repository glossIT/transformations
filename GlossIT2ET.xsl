<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xd xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="* | @* | text()">

        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>

    </xsl:template>

    <xsl:template match="t:text"/>

    <xsl:template match="t:zone/@rendition"/>

    <xsl:template match="t:facsimile">
        <xsl:element name="sourceDoc">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
<!--    <xsl:template match="t:gloss">
        <xsl:if test="count(child::t:ab) > 1">
            <zone type="gloss">
                <xsl:for-each select=".">
                    <xsl:apply-templates />
                </xsl:for-each>
            </zone>
        </xsl:if>
    </xsl:template>-->
    
    <xsl:template match="t:zone/t:zone">
        <xsl:variable name="id" select="@xml:id"/>
        <xsl:variable name="line_text" select="//t:ab[@facs = concat('#', $id)]"/>
        <xsl:variable name="gloss" select="concat(@xml:id, '_gloss')"/>
        <line>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="//t:ab[@facs = concat('#', $id)]/@type = 'textline'">
                    <xsl:attribute name="rendition">
                        <xsl:text>textline</xsl:text>
                    </xsl:attribute>
                    <xsl:for-each select="//t:ab[@facs = concat('#', $id)]/t:w">
                        <xsl:copy>
                            <xsl:apply-templates select="* | @* | text()"/>
                        </xsl:copy>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="//t:gloss/@xml:id = $gloss">
                    <xsl:attribute name="rendition">
                        <xsl:value-of select="$line_text/parent::t:gloss/@rendition"/>
                    </xsl:attribute>
                    <xsl:attribute name="corresp">
                        <xsl:value-of select="$line_text/parent::t:gloss/@target"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="count(child::t:gloss[@xml:id = $gloss]/t:ab) > 1">
                            <xsl:text>djsklfa</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="$line_text/text()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!--                    <xsl:if test="count(t:gloss[@xml:id=$gloss]/child::t:ab) > 1">
                        <zone type="gloss">
                        </zone>
                    </xsl:if>-->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="$line_text/text()"/>
                </xsl:otherwise>
            </xsl:choose>
        </line>
    </xsl:template>


</xsl:stylesheet>
