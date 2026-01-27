<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Sina Krottmaier and Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:p="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15 http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15/pagecontent.xsd"
    xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:local="local"
    xmlns:xstring="https://github.com/dariok/XStringUtils" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output encoding="UTF-8" indent="no" method="xml"/>
    <xd:doc>
        <xd:desc>Imports all the necessary XSLT Files for the steps.</xd:desc>
    </xd:doc>
    <xsl:import href="1GLOSSIT_page2teipage.xsl"/>
    <!-- step 1 -->
    <xsl:import href="2GLOSSIT_pagenumbers.xsl"/>
    <!-- step 2 -->
    <xsl:variable name="docNum">
        <xsl:analyze-string select="base-uri()" regex="doc\d+_">
            <xsl:matching-substring>
                <xsl:value-of select="."/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:variable>
    <xsl:variable name="docName">
        <xsl:value-of
            select="translate(substring-before(substring-after(base-uri(), $docNum), '_pagexml'), '_', ' ')"
        />
    </xsl:variable>
    <xd:doc>
        <xd:desc>Document will be saved as document-title + first.xml; Also the necessary variables
            - step 1 and step 2 are defined als well as an "all" variable, to step through the XSLT
            files.</xd:desc>
    </xd:doc>
    <xsl:template match="/" name="stepsInitiator">
        <xsl:result-document href="{concat($docName, '_first.xml')}">
            <xsl:variable name="all" select="."/>
            <xsl:variable name="step1">
                <xsl:copy>
                    <xsl:apply-templates mode="step1" select="$all"/>
                </xsl:copy>
            </xsl:variable>
            <xsl:variable name="step2">
                <xsl:copy>
                    <xsl:apply-templates mode="step2" select="$step1"/>
                </xsl:copy>
            </xsl:variable>        
            <xsl:copy-of select="$step2"/>
        </xsl:result-document>
        <xsl:result-document href="METS2.xml">
            <!-- Mini METS --> 
            
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
