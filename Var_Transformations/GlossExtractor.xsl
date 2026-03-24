<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Use Case:
    > Gets URIS of all Files in Folder based on METS
    > Outputs Filename and Folionumber (if annotated in the resp. pageXML)
    > Outputs a list of all glosses in the resp. PageXML
    > Outputs divider between files 
    > Result: One Textfile for all Glosses in a Manuscript, divided by the PageXML 
    Usage:
    > Create Oxygen Projekt inside MS Folder with METS
    > Create Transformation Scenario and save File as txt 
    > Use XSLT on METS in file
 -->
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:p="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15 http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15/pagecontent.xsd"
    xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink" 
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output encoding="UTF-8" indent="no" method="text"/>
    
    <xsl:template match="/">
        <xsl:for-each select="//mets:file[contains(@ID, 'export')]">
        <xsl:variable name="docID" select="mets:FLocat/@xlink:href"/>   
        <xsl:text>&#xa;</xsl:text>
        FileName: <xsl:value-of select="$docID"/>  ---- > Folio Num: <xsl:value-of select="document($docID)//p:TextRegion[contains(@custom, 'type:NumberingZone')]//p:Unicode"></xsl:value-of>
-----------------------------------------------------
        <xsl:for-each select="document($docID)//p:TextLine[contains(@custom, 'gloss')]">
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select=".//p:Unicode"/> 
        </xsl:for-each> 
____________________________________________________
____________________________________________________
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>