<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:variable name="folder">
        <xsl:value-of select="substring-after(base-uri(), 'Data/')"/>
    </xsl:variable>
    <xsl:variable name="filename" select="substring-before($folder, '/')"/>   
    <xsl:template match="*[@ana='view']">   
        <!-- Releeease them variables --> 
        <xsl:variable name="lineID" select="substring-after(./@facs, '#')"/>
        <xsl:variable name="zone" select="ancestor::t:TEI//t:zone[@xml:id=$lineID]/@points"/>           
        <xsl:variable name="imagefile" select="ancestor::t:TEI//t:zone[@xml:id=$lineID]/parent::t:zone[@rendition='TextRegion']/preceding-sibling::t:graphic[1]/@url"/>
        <!-- mathing --> 
        
        <xsl:variable name="coords" select="(concat('-', translate(translate($zone, ' ', '-'), '-', '- '), '- '))"/>
        <xsl:variable name="X">
            <x>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-before(., ','))" order="ascending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-before(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                    <!--    <xsl:value-of select="substring-after(substring-before(., ','), '-')"/>-->
                </xsl:for-each>
            </x>
        </xsl:variable>
        <xsl:variable name="Xmin">
            <xsl:value-of select="concat('0.' ,number(substring-before($X, ',')))"/>
        </xsl:variable>
        <xsl:variable name="Y">
            <y>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-after(., ','))" order="ascending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-after(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </y>
        </xsl:variable>
        <xsl:variable name="Ymin">
            <xsl:value-of select="concat('0.' ,number(substring-before($Y, ',')))"/>
        </xsl:variable>
        <xsl:variable name="Xmax">
            <x>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-before(., ','))" order="descending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-before(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>                  
                </xsl:for-each>
            </x>
        </xsl:variable>
        <xsl:variable name="width">
            <xsl:value-of select="concat('0.', number(substring-before($Xmax, ',')) - number(substring-before($X, ',')))"/>
        </xsl:variable>
        <xsl:variable name="Ymax">
            <y>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-after(., ','))" order="descending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-after(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </y>
        </xsl:variable>
        <xsl:variable name="height">
            <xsl:value-of select="concat('0.0',number(substring-before($Ymax, ',')) - number(substring-before($Y, ',')))"/>
        </xsl:variable>
      
        <xsl:result-document href="{resolve-uri('index.html', base-uri())}" omit-xml-declaration="yes"> 
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <script src="../OSD/openseadragon.js" type="text/javascript"><xsl:text> </xsl:text> </script>
                    
                    <title>GlossIT OSD Gloss-Snippet Viewer</title>
                   
                    
                </head>
                
                <body>
                    <h1>GlossIT OSD Gloss-Snippet Viewer</h1>
                    <div>
                    <p>Imagesnippet of <seg style="font-weight:bold;"><xsl:value-of select="upper-case(./@type)"/></seg> with Line ID: <u><xsl:value-of select="$lineID"/></u></p>
                        <p>Current Snippet Text:</p>   
                        <p><em><xsl:value-of select="."/></em>  </p>                                 
                    <xsl:value-of select="$Ymax"/>
                        <p><xsl:value-of select="$Y"/></p>
                        <p><xsl:value-of select="$height"/></p></div>
                    <div id="image">
                        <style>
                            
                            .navigator .highlight{
                            opacity:    0.4;
                            filter:     alpha(opacity=40);
                            outline:    2px solid #900;
                            background-color: #900;
                            }
                            .highlight{
                            opacity:    0.4;
                            filter:     alpha(opacity=40);
                            outline:    12px auto #0A7EbE;
                            background-color: transparent;
                            }
                            .highlight:hover, .highlight:focus{
                            filter:     alpha(opacity=70);
                            opacity:    0.7;
                            background-color: transparent;    
                            }
                        </style>
                        
                        
                        <script type="text/javascript">
                            
                            OpenSeadragon({
                            id:            "image",
                            prefixUrl:     "../OSD/images/",
                            tileSources: [{          
                            type: 'image',                       
                            url: <xsl:value-of select="concat('&quot;', '../', $filename, '/', $imagefile , '&quot;')"/> /*parameter*/ 
                            ,
                            overlays: [{
                            id: 'overlay',
                            x: <xsl:value-of select="$Xmin"/>, /* automatisiert */
                            y: <xsl:value-of select="$Ymin"/>, /* automatisiert */
                            width: <xsl:value-of select="$width"/>, /* automatisiert */
                            height: <xsl:value-of select="$height"/>,                      
                            className: 'highlight'
                            }]}],
                            defaultZoomLevel:   0,
                            minZoomLevel:   1,
                            maxZoomLevel:   5,
                            visibilityRatio:    1
                            });
                            
                        </script>
                    </div>    
                </body>
            </html>
       </xsl:result-document>
    </xsl:template>
   <xsl:template match="t:div[@type='dump']"></xsl:template>
</xsl:stylesheet>

