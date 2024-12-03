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
            <xsl:if test="contains(., '$')">
                <xsl:variable name="glossID">
                    <xsl:analyze-string select="." regex="\$\d+\$">
                        <xsl:matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:variable>
                <xsl:attribute name="n" select="$glossID"/>
            </xsl:if>
            <xsl:choose>
                
                <xsl:when test="ancestor::t:ab[@type = 'MainZone']">
                    <xsl:attribute name="xml:id">
                        <xsl:variable name="line-number">
                            <xsl:value-of select="following::t:ab[@type = 'textline'][1]/@n"/>
                        </xsl:variable>
                        <xsl:variable name="gloss-in-line">
                            <xsl:variable name="preceding_not_gloss_element" select="generate-id(preceding-sibling::*[not(self::t:gloss)][1])"/>
                            <xsl:if test="following-sibling::t:gloss[1] and not(preceding-sibling::t:gloss[1])">
                                <xsl:text>_1</xsl:text>
                            </xsl:if>
                            <xsl:if test="preceding-sibling::t:gloss[1]">
                                <xsl:value-of select="concat('_', count(preceding-sibling::t:gloss[not(@type='signe_de_renvoi')][generate-id(preceding-sibling::*[not(self::t:gloss)][1]) = $preceding_not_gloss_element][following-sibling::t:gloss[1]]) + 1)"/>
                            </xsl:if>
                        </xsl:variable>
<!--                        <xsl:variable name="glossID">
                            <xsl:analyze-string select="." regex="\$\d+\$">
                                <xsl:matching-substring>
                                    <xsl:value-of select="translate(., '$', '')"/>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                        </xsl:variable>-->
                        <xsl:value-of
                            select="concat($manuscript, '_', $pf-number, '_', $line-number, $gloss-in-line)"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="ancestor::t:ab[@type = 'MainZone:column_right'] or ancestor::t:ab[@type = 'MainZone:column_left']">
                    <xsl:attribute name="xml:id">
                        <xsl:variable name="column">
                            <xsl:choose>
                                <xsl:when test="ancestor::t:ab[@type = 'MainZone:column_right']">
                                    <xsl:text>rc</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>lc</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="line-number">
                            <xsl:value-of select="following::t:ab[@type = 'textline'][1]/@n"/>
                        </xsl:variable>
                        <xsl:variable name="gloss-in-line">
                            <xsl:variable name="preceding_not_gloss_element" select="generate-id(preceding-sibling::*[not(self::t:gloss)][1])"/>
                            <xsl:if test="following-sibling::t:gloss[1] and not(preceding-sibling::t:gloss[1])">
                                <xsl:text>_1</xsl:text>
                            </xsl:if>
                            <xsl:if test="preceding-sibling::t:gloss[1]">
                                <xsl:value-of select="concat('_', count(preceding-sibling::t:gloss[not(@type='signe_de_renvoi')][generate-id(preceding-sibling::*[not(self::t:gloss)][1]) = $preceding_not_gloss_element][following-sibling::t:gloss[1]]) + 1)"/>
                            </xsl:if>
                        </xsl:variable>
                        <xsl:value-of
                            select="concat($manuscript, '_', $pf-number, '_', $column, '_', $line-number, $gloss-in-line)"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <!--This is for marginal and intercolumnar glosses-->
                    <xsl:variable name="marginal-gloss-number">
                        <xsl:if test="not(preceding-sibling::t:gloss[not(@type='signe_de_renvoi')])">
                            <xsl:text>1</xsl:text>
                        </xsl:if>
                        <xsl:if test="preceding-sibling::t:gloss[not(@type='signe_de_renvoi')]">
                            <xsl:value-of select="count(preceding-sibling::t:gloss[not(@type='signe_de_renvoi')]) + 1"/>
                        </xsl:if>
                    </xsl:variable>
                    <xsl:variable name="line-number">
                        <xsl:value-of select="following::t:ab[@type = 'textline'][1]/@n"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:outer']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, '_mo_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:inner']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, '_mi_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:upper']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, '_mu_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MarginTextZone:lower']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, '_ml_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
<!--                        <xsl:when test="ancestor::t:ab[@type = 'MainZone:column_right']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, '_rc_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="ancestor::t:ab[@type = 'MainZone:column_left']">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, '_lc_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:when>-->
                        <xsl:otherwise>
                            <xsl:attribute name="xml:id">
                                <xsl:value-of
                                    select="concat($manuscript, '_', $pf-number, '_ic_', $marginal-gloss-number)"
                                />
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            <lb facs="{./t:lb/@facs}" n="{./t:lb/@n}"/>
            <xsl:value-of select="."/>
        </gloss>
    </xsl:template>    
    <xsl:template match="t:lb" mode="step6">
        <lb facs="{./@facs}" n="{./@n}"/>
    </xsl:template>
    <!-- GlossLinking --> 
    <xsl:template match="t:ab[@type='textline']" mode="step6">   
        <xsl:for-each select=".">
            <xsl:variable name="dollarscore">
            <xsl:analyze-string select="." regex="\$">
                <xsl:matching-substring>
                    <xsl:value-of select="string-length(.)"/>
                </xsl:matching-substring>
            </xsl:analyze-string>
            </xsl:variable>
           
          <xsl:variable name="counter" select="string-length($dollarscore)"/>          
            <xsl:choose>
                <xsl:when test="$counter = 4">
                    <xsl:variable name="textIDstart">
                        <xsl:analyze-string select="." regex="\$[0-9]+\$">
                            <xsl:matching-substring>
                                <xsl:value-of select="."/>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:variable>
                    <xsl:variable name="textIDend">
                        <xsl:analyze-string select="." regex="\$&#47;[0-9]+\$"> <!-- $/6$ --> 
                            <xsl:matching-substring>
                                <xsl:value-of select="."/>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:variable> 
                    <ab type="{./@type}" n="{./@n}"> 
                        <lb facs="{./t:lb/@facs}" n="{./t:lb/@n}"/>
                        <xsl:value-of select="substring-before(., $textIDstart)"/>
                        <seg><xsl:attribute name="n" select="$textIDstart"/>
                            <xsl:attribute name="corresp" select="$textIDstart"/>                               
                            <xsl:value-of select="substring-after(substring-before(./text(), $textIDend), $textIDstart)"/></seg>
                        <xsl:value-of select="substring-after(., $textIDend)"/></ab>
                </xsl:when>   
                <xsl:when test="$counter > 4">
                <xsl:variable name="anchors">
                    <xsl:analyze-string select="." regex="(\$[0-9]+\$)+|(\$&#47;[0-9]+\$)+">
                            <xsl:matching-substring>
                                                                                            
                                <anchor n="{.}">
                                    <xsl:attribute name="type">
                                        <xsl:if test="contains(.,'/')">
                                            <xsl:value-of select="concat('$', substring-after(.,'$/'))"/>
                                        </xsl:if>
                                        <xsl:if test="not(contains(., '/'))">
                                            <xsl:value-of select="'start'"/>
                                        </xsl:if>
                                    </xsl:attribute>
                                </anchor>
                            </xsl:matching-substring>    
                            <xsl:non-matching-substring>
                                <text><xsl:value-of select="."/></text>
                            </xsl:non-matching-substring>
                        </xsl:analyze-string>
                    </xsl:variable>               
                    
                    <ab type="{./@type}" n="{./@n}">
                        <lb facs="{./t:lb/@facs}" n="{./t:lb/@n}"/>                        
                        <multiGloss><xsl:copy-of select="$anchors"/></multiGloss> 
                       </ab>
                </xsl:when>
                <xsl:otherwise>                   
                    <ab type="{./@type}" n="{./@n}">
                        <lb facs="{./t:lb/@facs}" n="{./t:lb/@n}"/>
                        <xsl:value-of select="."/>
                    </ab>
                </xsl:otherwise>
            </xsl:choose>
        
        </xsl:for-each>
    
        
    </xsl:template>
</xsl:stylesheet>
