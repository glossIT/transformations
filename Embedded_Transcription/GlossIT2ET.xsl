<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case: Turn connected TEIs into embedded transcription TEIs
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xd xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="* | @* | text()">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="t:text"/>
    <!--Removing the text-element-->

    <xsl:template match="t:zone/@rendition"/>

    <xsl:template match="t:facsimile">
        <!--Changing the facsimile-element to sourceDoc-->
        <xsl:element name="sourceDoc">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="t:zone/t:zone">
        <!--Setting up the zones and importing the respective lines, i.e. main text, glosses, folio-numbers-->
        <xsl:variable name="id" select="@xml:id"/>
        <xsl:variable name="line_text" select="//t:ab[@facs = concat('#', $id)]"/>
        <xsl:variable name="gloss" select="concat(@xml:id, '_gloss')"/>
        <xsl:choose>
            <xsl:when test="//t:ab[@facs = concat('#', $id)]/@type = 'textline'">
                <!--                For headings-->
                <xsl:choose>
                    <xsl:when test="//t:ab[@facs = concat('#', $id)]/@subtype">
                        <zone>
                            <xsl:attribute name="type">
                                <xsl:text>textline</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="substring-after(concat(//t:ab[@facs = concat('#', $id)]/@facs, '_heading'), '#')"/>
                            </xsl:attribute>
                            <xsl:attribute name="rendition">
                                <xsl:text>heading</xsl:text>
                            </xsl:attribute>
                            <line>
                                <xsl:apply-templates select="@*[not(name() = 'rotate')]"/>
                                <xsl:attribute name="rendition">
                                    <xsl:text>heading</xsl:text>
                                </xsl:attribute>
                                <xsl:for-each select="//t:ab[@facs = concat('#', $id)]/t:w">
                                    <xsl:copy>
                                        <xsl:apply-templates select="* | @* | text()"/>
                                    </xsl:copy>
                                </xsl:for-each>
                            </line>
                        </zone>
                    </xsl:when>
                    <!--For main text-->
                    <xsl:otherwise>
                        <zone>
                            <xsl:attribute name="type">
                                <xsl:text>textline</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="substring-after(concat(//t:ab[@facs = concat('#', $id)]/@facs, '_maintext'), '#')"/>
                            </xsl:attribute>
                            <xsl:attribute name="rendition">
                                <xsl:text>maintext</xsl:text>
                            </xsl:attribute>
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
                        </zone>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="//t:gloss/@xml:id = $gloss">
                <!--For glosses-->
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
                    <xsl:attribute name="rendition">
                        <xsl:value-of select="//t:gloss[@xml:id = $gloss]/@rendition"/>
                    </xsl:attribute>
                    <xsl:for-each select="//t:gloss[@xml:id = $gloss]/t:ab">
                        <line>
                            <xsl:variable name="line_id">
                                <xsl:value-of select="substring-after(@facs, '#')"/>
                            </xsl:variable>
                            <xsl:apply-templates select="//t:zone[@xml:id = $line_id]/@*[not(name() = 'rotate')]"/>
                            <xsl:attribute name="rendition">
                                <xsl:value-of select="./parent::t:gloss/@rendition"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="./text()"/>
                        </line>
                    </xsl:for-each>
                </zone>
            </xsl:when>
            <xsl:when test="//t:fw/@facs = $id">
                <!--For folio/page numbers-->
                <zone>
                    <xsl:attribute name="type">
                        <xsl:text>numbering</xsl:text>
                    </xsl:attribute>
                    <line>
                        <xsl:apply-templates select="@*[not(name() = 'rotate')]"/>
                        <xsl:attribute name="rendition">
                            <xsl:value-of select="//t:fw/@type"/>
                        </xsl:attribute>
                        <xsl:apply-templates select="//t:fw[@facs = $id]/text()"/>
                    </line>
                </zone>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="t:zone/@n">
        <xsl:attribute name="type">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

</xsl:stylesheet>
