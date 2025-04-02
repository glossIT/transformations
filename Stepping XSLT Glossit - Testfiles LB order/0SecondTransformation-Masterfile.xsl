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
    <xsl:import href="3GLOSSIT_textlineNumbers.xsl"/> <!-- step 3 -->
    <xsl:import href="4GLOSSIT_lbNumbers.xsl"/> <!-- step 4 -->
    <xsl:import href="5GLOSSIT_merge_glosses.xsl"/> <!-- step 5 -->
    <xsl:import href="6GLOSSIT_lbReorder.xsl"/> <!-- step 6 --> 
    <xsl:import href="7GLOSSIT_glossTypes.xsl"/> <!-- step 7 -->   
    <xsl:import href="8GLOSSIT_glossIDs.xsl"/> <!-- step 8 -->

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
    <xsl:template match="/" name="stepsInitiator">
        <xsl:result-document href="{concat($docName, '_second.xml')}">
            <xsl:variable name="all" select="."/>
            <xsl:variable name="step3">
                <xsl:copy>
                    <xsl:apply-templates mode="step3" select="$all"/>
                </xsl:copy>                
            </xsl:variable>
            <xsl:variable name="step4">
                <xsl:copy>
                    <xsl:apply-templates mode="step4" select="$step3"/>
                </xsl:copy>
            </xsl:variable>
            <xsl:variable name="step5">
                <xsl:copy>
                    <xsl:apply-templates mode="step5" select="$step4"/>
                </xsl:copy>
            </xsl:variable>
            <xsl:variable name="step6">
                <xsl:copy><xsl:apply-templates mode="step6" select="$step5"/></xsl:copy>
            </xsl:variable>
            <xsl:variable name="step7">
                <xsl:copy><xsl:apply-templates mode="step7" select="$step6"/></xsl:copy>
            </xsl:variable>
            <xsl:variable name="step8">
                <xsl:copy><xsl:apply-templates mode="step8" select="$step7"/></xsl:copy>
            </xsl:variable>

            <xsl:copy-of select="$step8"/>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>