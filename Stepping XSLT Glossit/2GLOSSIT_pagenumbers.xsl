<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
  <xsl:template match="* | @*" mode="step2">     
        <xsl:copy>
            <xsl:apply-templates mode ="step2" select="* | @* |text()"/>
        </xsl:copy>
    </xsl:template>
  
    
    <xsl:template match="t:pb[@n = 'p. ']/@n" mode="step2">
        <xsl:attribute name="n">
            <xsl:value-of select="concat(substring-before(preceding::t:pb[1]/@n, 'r'), 'v')"/>
        </xsl:attribute>
    </xsl:template>
    
    
<!--    Ordering the zones according to their coordinates, we are taking the final number of the coordinates   -->
  <xsl:template match="t:zone[@rendition = 'TextRegion']" mode="step2">
      <xsl:variable name="n">
          <xsl:value-of select="substring-after(substring-after(substring-after(substring-after(./@points, ','), ','), ','), ',')"/>
      </xsl:variable>
       <xsl:for-each select=".">
      
           <xsl:sort select="number(substring-after(substring-after(substring-after(substring-after(./@points, ','), ','), ','), ','))" data-type="number" order="ascending"/>
           <zone points="{@points}" rendition="{@rendition}" rotate="{@rotate}" xml:id="{@xml:id}" n="{$n}"/>
           
       </xsl:for-each>
      <!--<xsl:copy>
         
            <xsl:apply-templates select="t:zone">
                <xsl:sort select="substring-after(substring-after(substring-after(substring-after(@points, ','), ','), ','), ',')" data-type="number" order="ascending"/>
            </xsl:apply-templates>
        </xsl:copy>-->
    <xsl:apply-templates mode="lineSort"/>
    </xsl:template>
    
    <xsl:template name="sorter">
        <xsl:apply-templates>
            <xsl:sort select="number(substring-after(substring-after(substring-after(substring-after(./@points, ','), ','), ','), ','))" data-type="number" order="ascending"/>
        </xsl:apply-templates>
    </xsl:template>
    
<!-- Adding an attribute n to each TextLine which helps to reorder the lbs for each textregion-->
    <xsl:template match="t:zone[@rendition='TextLine']" mode="lineSort" name="lineSort">
        
        <xsl:for-each select=".">
            <xsl:variable name="lastYstanding">
                <xsl:value-of select="number(substring-after(substring-after(substring-after(substring-after(./@points, ','), ','), ','), ','))"/>
            </xsl:variable>
            <xsl:value-of select="$lastYstanding"/>
           <!-- -->
            <xsl:apply-templates>
                <xsl:sort select="number(substring-after(substring-after(substring-after(substring-after(./@points, ','), ','), ','), ','))" data-type="number" order="ascending"/>
                
            </xsl:apply-templates>
           <zone points="{@points}" rendition="{@rendition}" rotate="{@rotate}" xml:id="{@xml:id}"></zone>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>