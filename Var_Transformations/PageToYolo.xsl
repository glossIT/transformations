<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Usage: Transform Escriptorium PageXML to YoloFormat
    Author: Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    
    
    
    Classes:

Maintextline  0
Title 1
Glosses:
	Interlinear 2 (also number / correction) 
	Marginal 3
Reference Signs 4
Signe 5
Folio 6
MainZone 7
Margin Outer 8
Margin inner 9
Margin upper 10
Margin lower 11   


}
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:page="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:ex="http://example.com/ex"
    exclude-result-prefixes="xs page ex"
    version="2.0">
    <xsl:output encoding="UTF-8" indent="no" method="text"/>
    <xsl:variable name="fileName" select="substring-before(base-uri(), '.xml')"/>
    <xsl:template match="/">
        <xsl:result-document href="{normalize-space(concat($fileName, '.txt'))}">
            <xsl:variable name="imageHeight" select="//page:Page/@imageHeight"/>
            <xsl:variable name="imageWidth" select="//page:Page/@imageWidth"/>
            <!-- Abfertigung der Regions -->
            <!-- object_ids -->
            
            <xsl:for-each select="//page:TextRegion">
                <xsl:choose>
                    <xsl:when test="./@custom = 'structure {type:MarginTextZone:inner;}'">
                        <xsl:text>9 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>             
                    <xsl:when test="./@custom = 'structure {type:MarginTextZone:outer;}'">
                        <xsl:text>8 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="./@custom = 'structure {type:MarginTextZone:upper;}'">
                        <xsl:text>10 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="./@custom = 'structure {type:MarginTextZone:lower;}'">
                        <xsl:text>11 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="./@custom = 'structure {type:MainZone;}'">
                        <xsl:text>7 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="./@custom ='structure {type:NumberingZone:folio;}'">
                        <xsl:text>6 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="./@custom"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>                      
            </xsl:for-each>
            <xsl:for-each select="//page:TextLine">
                <xsl:choose>
                    <xsl:when test="./@custom = 'structure {type:default;}' or ./@custom = 'structure {type:DefaultLine;}' ">
                        <xsl:text>0 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>             
                    <xsl:when test="./@custom = 'structure {type:HeadingLine:title;}'">
                        <xsl:text>1 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="./@custom = 'structure {type:MarginalLine:gloss;}'">
                        <xsl:text>3 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="./@custom = 'structure {type:InterlinearLine:gloss;}' or ./@custom = 'structure {type:InterlinearLine:correction;}' or ./@custom = 'structure {type:InterlinearLine:number;}'">
                        <xsl:text>2 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="./@custom = 'structure {type:InterlinearLine:signe_de_renvoi;}'">
                        <xsl:text>5 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:when>
                    <xsl:when test="./@custom = 'structure {type:Reference_sign;}'">
                        <xsl:text>4 </xsl:text>
                        <xsl:value-of select="ex:normalizer(./page:Coords/@points, $imageHeight, $imageWidth)"/>
                        <xsl:if test="not(last())"><xsl:text>&#xa;</xsl:text></xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="./@custom"/>
                        <xsl:text>&#xa;</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>                      
            </xsl:for-each>
        </xsl:result-document> 
    </xsl:template>
    
    <xsl:function name="ex:normalizer">
        <xsl:param name="Coords"/>
        <xsl:param name="imageHeight"/> <!-- document Height -->
        <xsl:param name="imageWidth"/> <!-- document Width --> 
        <xsl:variable name="me">  
            <xsl:for-each select="tokenize($Coords, ' ')">
                <a><xsl:text>(</xsl:text><xsl:value-of select="."/><xsl:text>)</xsl:text></a>
            </xsl:for-each>
        </xsl:variable> 
        <xsl:for-each select="$me/a">
            <xsl:value-of select="number(substring-before(substring-after(., '('), ',')) div number($imageWidth)"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="number(substring-before(substring-after(., ','), ')')) div number($imageHeight)"/>
            <xsl:text> </xsl:text>
        </xsl:for-each> 
    </xsl:function> 
</xsl:stylesheet>