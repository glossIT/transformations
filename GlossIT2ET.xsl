<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xd xsl" version="2.0">
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
        <xsl:choose>
            <xsl:when test="//t:ab[@facs = concat('#', $id)]/@type = 'textline'">
                <line>
                    <xsl:apply-templates select="@*[not(name() = 'rotate')]"/>
                    <xsl:attribute name="rendition">
                        <xsl:text>textline</xsl:text>
                    </xsl:attribute>
                    <xsl:for-each select="//t:ab[@facs = concat('#', $id)]/t:w">
                        <xsl:copy>
                            <xsl:apply-templates select="* | @* | text()"/>
                        </xsl:copy>
                    </xsl:for-each>
                </line>
            </xsl:when>
            <xsl:when test="//t:gloss/@xml:id = $gloss">
                <zone>
                    <xsl:attribute name="type">
                        <xsl:text>gloss</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="corresp">
                        <xsl:value-of select="//t:gloss[@xml:id = $gloss]/@target"/>
                    </xsl:attribute>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="//t:gloss[@xml:id = $gloss]/@xml:id"/>
                    </xsl:attribute>
                    <xsl:for-each select="//t:gloss[@xml:id = $gloss]/t:ab">
                        <line>
                            <xsl:variable name="line_id">
                                <xsl:value-of select="substring-after(@facs, '#')"/>
                            </xsl:variable>
                            <xsl:apply-templates select="//t:zone[@xml:id=$line_id]/@*[not(name() = 'rotate')]"/>
                            <xsl:attribute name="rendition">
                                <xsl:value-of select="./parent::t:gloss/@rendition"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="./text()"/>
                        </line>
                    </xsl:for-each>
                </zone>
            </xsl:when>
            <xsl:when test="//t:fw/@xml:id = $id">
                <line>
                    <xsl:apply-templates select="@*[not(name() = 'rotate')]"/>
                    <xsl:attribute name="rendition">
                        <xsl:value-of select="//t:fw/@type"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="//t:fw/text()"/>
                </line>
            </xsl:when>
        </xsl:choose>
    </xsl:template>



</xsl:stylesheet>
