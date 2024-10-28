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
    <xsl:template mode="step6" match="* | @*">
        <!-- Copy All -->
        <xsl:copy>
            <xsl:apply-templates mode="step6" select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    <!--    Here starts the numbering of the glosses-->
    <xsl:template match="t:gloss[@type = 'gloss']" mode="step6">
        <!--        THIS IS SINGLE-COLUMN MANUSCRIPTS;-->
       
        <gloss>
            <xsl:variable name="manuscript">
                <xsl:value-of select="//t:msIdentifier/t:idno"/>
            </xsl:variable>
            <xsl:variable name="pf-number">
                <xsl:value-of select="substring-after(preceding::t:pb[1]/@n, ' ')"/>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="ancestor::t:ab[@type = 'MainZone']">
                    <xsl:attribute name="xml:id">
                        <xsl:variable name="line-number">
                            <xsl:value-of select="following::t:ab[@type = 'textline'][1]/@n"/>
                        </xsl:variable>
                        <xsl:variable name="gloss-in-line">
                            <xsl:if test="not(preceding-sibling::t:gloss)">
                                <xsl:text>1</xsl:text>
                            </xsl:if>
                            <xsl:if test="preceding-sibling::t:gloss">
                                <xsl:value-of select="count(preceding-sibling::t:gloss) + 1"/> 
                            </xsl:if> 
                        </xsl:variable>
                        <xsl:variable name="glossID">
                            <xsl:analyze-string select="." regex="\$\d+\$">
                                <xsl:matching-substring>
                                    <xsl:value-of select="translate(., '$', '')"/>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                        </xsl:variable>
                        <xsl:value-of
                            select="concat($manuscript, '_', $pf-number, '_', $line-number, '_', $gloss-in-line)"/>
                        <!--<xsl:if test="following-sibling::*[1][self::t:gloss] or $gloss-in-line > 1">
                            <xsl:value-of select="concat('.', $gloss-in-line, '_', $glossID)"/>
                        </xsl:if>-->
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <!--This is for marginal and intercolumnar glosses-->
                    <xsl:variable name="marginal-gloss-number">
                        <xsl:if test="not(preceding-sibling::t:gloss)">
                            <xsl:text>1</xsl:text>
                        </xsl:if>
                        <xsl:if test="preceding-sibling::t:gloss">
                            <xsl:value-of select="count(preceding-sibling::t:gloss) + 1"/> 
                        </xsl:if>              
                    </xsl:variable>
                    
                    <xsl:variable name="line-number">
                        <xsl:value-of select="following::t:ab[@type = 'textline'][1]/@n"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:outer']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'mo_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:inner']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'mi_',  $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:upper']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'mu_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:lower']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'ml_',  $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, 'ic_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:otherwise>
            </xsl:choose>            
           <xsl:value-of select="."/>
            
        </gloss>
    </xsl:template>


<!--Change the @type of the glosses to interlinear, intercolumnar and marginal-->
    <!--<xsl:template match="t:gloss/t:lb" mode="step6">
      <lb xml:id="{./@xml:id}" n="{./@n}"/>
    </xsl:template>-->
    
    
    <xsl:template match="t:gloss[@type='gloss']/@type" mode="step6">
        <xsl:choose>
            <xsl:when test="ancestor::t:ab[@type = 'MainZone']">
                <xsl:attribute name="type">
                    <xsl:text>interlinear_gloss</xsl:text>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="ancestor::t:ab[@type = 'Intercolumnar']">
                <xsl:attribute name="type">
                    <xsl:text>intercolumnar_gloss</xsl:text>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="type">
                    <xsl:text>marginal_gloss</xsl:text>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
  <!--  <xsl:template match="t:ab[@type='textline']/text()" mode="step6">        
        <xsl:copy><xsl:variable name="textIDstart">
           <xsl:analyze-string select="." regex="\$\d+\$">
               <xsl:matching-substring>
                   <xsl:value-of select="."/>
               </xsl:matching-substring>
           </xsl:analyze-string>
        </xsl:variable>
        <xsl:variable name="textIDend">
            <xsl:analyze-string select="." regex="\$\d+&#47;\$">
                <xsl:matching-substring>
                    <xsl:value-of select="."/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
     ´ <xsl:variable name="glossID">
            <xsl:analyze-string select="./parent::t:ab/preceding-sibling::t:ab/t:gloss/text()" regex="\$\d+\$">
                <xsl:matching-substring>
                    <xsl:value-of select="."/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:for-each select=".">
        <xsl:if test="contains(./text(), $textIDstart)">
        <xsl:value-of select="substring-before(./text(), $textIDstart)"/>    
        <seg>
           <!-\- <xsl:attribute name="target">
                <xsl:text>AAAAH</xsl:text>
                <!-\\-<xsl:if test="$textIDend = parent::t:ab/ancestor-or-self::t:ab/t:gloss"-\\->
            </xsl:attribute>-\->
        <xsl:value-of select="substring-after(substring-before(., $textIDend), $textIDstart)"/></seg>
        <xsl:value-of select="substring-after(., $textIDend)"/>
        </xsl:if></xsl:for-each></xsl:copy>
        <xsl:variable name="glossID">
            <xsl:analyze-string select="." regex="\$\d+\$">
                <xsl:matching-substring>
                    <xsl:value-of select="translate(., '$', '')"/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
    </xsl:template>-->
  
</xsl:stylesheet>
