<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Tristan Repolusk 
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case: The facsimile tags <surface> and <graphic> have all have the same xml:id.
              We change this to make the xml:id unique according to their order.
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xd:doc>
        <xd:desc>copies all the data</xd:desc>
    </xd:doc>
    <xsl:template match="* | @*">
        <xsl:copy>
            <xsl:apply-templates select="* | @*[normalize-space()] | text()"/> <!--Empty attributes like ulx="" are removed-->
        </xsl:copy>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Match everything except for those with a more specific rule</xd:desc>
    </xd:doc>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Update the xml:id of surface</xd:desc>
    </xd:doc>
    <xsl:template match="t:surface">
        <xsl:copy>
            <!-- Copy all attributes except xml:id -->
            <xsl:apply-templates select="@*[not(name()='xml:id')]"/>
            <!-- Add new xml:id attribute -->
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('facs_', count(preceding::t:surface)+1)"/>
            </xsl:attribute>
            <!-- Copy all child nodes (elements, text, etc.) -->
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Update the xml:id of graphic</xd:desc>
    </xd:doc>
    <xsl:template match="t:graphic">
        <xsl:copy>
            <!-- Copy all attributes except xml:id -->
            <xsl:apply-templates select="@*[not(name()='xml:id')]"/>
            <!-- Add new xml:id attribute -->
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('IMAGE.', count(preceding::t:graphic)+1)"/>
            </xsl:attribute>
            <!-- Copy all child nodes (elements, text, etc.) -->
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Update the facs target of pb</xd:desc>
    </xd:doc>
    <xsl:template match="t:pb">
        <xsl:copy>
            <!-- Copy all attributes except facs -->
            <xsl:apply-templates select="@*[not(name()='facs')]"/>
            <!-- Add new facs attribute -->
            <xsl:attribute name="facs">
                <xsl:value-of select="concat('facs_', count(preceding::t:pb)+1)"/>
            </xsl:attribute>
            <!-- Copy all child nodes (elements, text, etc.) -->
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
   
    
</xsl:stylesheet>
