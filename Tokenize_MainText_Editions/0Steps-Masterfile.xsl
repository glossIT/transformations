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
   <xsl:import href="1GLOSSIT_TokenizeRomanNumerals.xsl"/>
   <!-- step 1 -->
   <xsl:import href="2GLOSSIT_Punctuation.xsl"/>
   <!-- step 2 -->
   <xsl:import href="3GLOSSIT_TokenizeLines.xsl"/>
   <!-- step 3 -->
   <xsl:import href="4GLOSSIT_RemoveEmptyw.xsl"/>
   <!-- step 4 -->
   <xsl:import href="5GLOSSIT_IDs4w.xsl"/>
   <!-- step 5 -->

   <xsl:variable name="docName">
      <xsl:value-of select="substring-before(base-uri(), '.')"/>
   </xsl:variable>


   <xsl:template match="/" name="stepsInitiator">
      <xsl:result-document href="{concat($docName, '_tokenized.xml')}">
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
         <xsl:variable name="step3">
            <xsl:copy>
               <xsl:apply-templates mode="step3" select="$step2"/>
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
         <xsl:copy-of select="$step5"/>
      </xsl:result-document>
   </xsl:template>
</xsl:stylesheet>
