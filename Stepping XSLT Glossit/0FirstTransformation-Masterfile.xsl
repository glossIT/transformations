<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Sina Krottmaier and Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0"
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
  
   <!-- =^.^= Variables =^.^= --> 
  
    <xsl:variable name="docUri" select="base-uri()"/>
   <!-- <xsl:variable name="currFileName" select="(tokenize($docUri, '/'))[last()]"/>
    <xsl:variable name="currImageName" select="concat(substring-before($currFileName, '.xml'), '.jpg')"/> -->
    <xsl:variable name="folderPath" select="tokenize($docUri, '/')"/>
    <xsl:variable name="folderName" select="$folderPath[count($folderPath) - 1]"/>     
        



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
    
    <xsl:variable name="docName">
</xsl:variable>
    <xd:doc>
        <xd:desc>Document will be saved as document-title + first.xml; Also the necessary variables
            - step 1 and step 2 are defined als well as an "all" variable, to step through the XSLT
            files.</xd:desc>
    </xd:doc>
    <!-- =^.^= says: Take the tei saved in the steps2 variable, create files for each pb (page), name the file like this {MS_folnum} and create a mini-mets with the name {MS_Fol_mets] -->
    <xsl:template match="/" name="stepsInitiator"> 
       
        <xsl:for-each select="$step2//t:pb">
            <xsl:variable name="ID" select="@facs"/>
            <xsl:variable name="fol" >  
            <xsl:value-of select="substring-after(./@n, 'fol. ')"/>            
            </xsl:variable>
            <xsl:variable name="fileName" select="substring-before(@corresp, '.jpg')"></xsl:variable>
            <xsl:variable name="folNum">
                <xsl:choose>
                    <xsl:when test="matches($fol, '\d+[r|v]')">
                    <xsl:value-of select="$fol"/>
                </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat('MISSINGFOL_', $fol)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:result-document href="{concat($folderName, '_', $folNum, '_', $fileName,  '.xml')}">
                <TEI>
                <xsl:copy-of select="./ancestor::t:text/preceding-sibling::*"></xsl:copy-of>
                <text>
                    <body>
                        <div type="page">
                        <xsl:copy-of select="."/>
                          
                          <xsl:copy-of select="./following-sibling::node()[preceding-sibling::t:pb[1]/@facs = $ID][not(self::t:pb)]"/>
                        </div>
                    </body>
                </text>   
                </TEI>
            </xsl:result-document> 
          
        </xsl:for-each>
            
          
            
       <!-- <xsl:result-document href="Test/METS2.xml"> <!-\- Creates the Mini Mets -\-> 
            <!-\- Mini METS -\-> 
            <xsl:value-of select="$folderName"/>
            MEEEH
       
        </xsl:result-document>-->
    </xsl:template>
</xsl:stylesheet>
