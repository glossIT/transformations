<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Sina Krottmaier and Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Usa Case:
    > Main XSLT File for Data Transformation.
    > includes the two xslt steps necessary
    > Creates a TEI for each PB and saves it with the following name {OrigName}_{Abbr}_{Fol}.
    > Creates Mini-Mets per pageXml 
    > ATTENTION: Needs to be executed on METS file 
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
        <xd:desc>=^.^= says: 
            Import all the necessary XSLT Files for the steps.</xd:desc>
    </xd:doc>
    <xsl:import href="1GLOSSIT_page2tei.xsl"/>
    <!-- step 1 -->
    <xsl:import href="2GLOSSIT_pagenumbers.xsl"/>
    <!-- step 2 -->
  
   <!-- =^.^= Variables =^.^= -->  
    <xsl:variable name="docUri" select="base-uri()"/>
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
   
    <xd:doc>
        <xd:desc> =^.^= says: 
            > Take the TEI saved in the steps2 variable
            > Create files for each pb (page)
            > Name the file like this {OrigNam}_{Abbr}_{Fol}
            > Create a mini-mets with the name {OrigNam}_{Abbr}_{Fol}_METS</xd:desc>
    </xd:doc>  
    <xsl:template match="/" name="stepsInitiator"> 
        <xsl:for-each select="$step2//t:pb">
            <xsl:variable name="ID" select="@facs"/> <!-- Variable to find the right siblings to pb --> 
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
            <xsl:result-document href="{concat( $fileName, '_', $folderName, '_', $folNum,  '.xml')}"> <!-- Create TEI files --> 
                <TEI>
                <xsl:copy-of select="./ancestor::t:text/preceding-sibling::*"></xsl:copy-of> <!-- Copies the teiHeader and the facsimile into the file --> 
                <text>
                    <body>
                        <div type="page">
                        <xsl:copy-of select="."/> <!-- copy the pb -->
                            <!-- copy all following siblings, whose preceding pb has a facs, that matches the ID variable but is not a pb itself --> 
                          <xsl:copy-of select="./following-sibling::node()[preceding-sibling::t:pb[1]/@facs = $ID][not(self::t:pb)]"/>
                        </div>
                    </body>
                </text>   
                </TEI>
            </xsl:result-document> 
            <xsl:result-document href="{concat( $fileName, '_', $folderName, '_', $folNum,  '_METS.xml')}"> <!-- Create METS files // base mets starting at 1 per mets  --> 
                <mets xmlns="http://www.loc.gov/METS/">
                    <xsl:namespace name = "xlink" select = "'http://www.w3.org/1999/xlink'"/>
                    <fileSec>
                        <fileGrp USE="image">
                            <file ID="image1">
                                <FLocat xlink:href="{concat($fileName, '.jpg')}"/>
                            </file>
                        </fileGrp>
                        <fileGrp USE="export">
                            <file ID="export1">
                                <FLocat  xlink:href="{concat($fileName, '.xml')}"/>
                            </file>
                        </fileGrp>
                    </fileSec>
                    <structMap TYPE="physical">
                        <div TYPE="document">
                            <div TYPE="page">
                                <fptr FILEID="image1"/>
                                <fptr FILEID="export1"/>
                            </div>
                        </div>
                    </structMap>
                    </mets>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
