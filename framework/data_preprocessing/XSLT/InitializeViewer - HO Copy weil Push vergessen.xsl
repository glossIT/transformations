<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <!--<xsl:output method="html" indent="yes"/>-->
    <xsl:strip-space elements="*"/>
   <!-- <xsl:template match="* | @*">-->
        
        <!-- Copy All -->
       <!-- <xsl:copy>           
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>-->
    
    
    <!-- <zone points="448,767 468,767 468,788 448,788"
      rendition="TextLine" rotate="0" xml:id="eSc_line_af58f913" n="70"/> --> 
    
    <xsl:variable name="folder">
        <xsl:value-of select="substring-after(base-uri(), 'Data/')"/>
    </xsl:variable>
    <xsl:variable name="filename" select="substring-before($folder, '/')"/>
   
    
    <xsl:template match="t:ab[@ana='view']">   
        <!-- Releeease them variables --> 
        <xsl:variable name="lineID" select="substring-after(./@facs, '#')"/>
        <xsl:variable name="zone" select="ancestor::t:TEI//t:zone[@xml:id=$lineID]/@points"/>           
        <xsl:variable name="imagefile" select="ancestor::t:TEI//t:zone[@xml:id=$lineID]/parent::t:zone[@rendition='TextRegion']/preceding-sibling::t:graphic[1]/@url"/>
         
        <xsl:result-document href="./index.html"> 
            <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <script src="../OSD/openseadragon.js" type="text/javascript"><xsl:text> </xsl:text> </script>
                
                <title><xsl:text> </xsl:text></title>
                <style><xsl:text> </xsl:text></style>
                
            </head>
            <xsl:value-of select="tokenize($zone, ' ')"/>
                
                <body><h2><xsl:value-of select="$lineID"/></h2>
                    <h3><xsl:value-of select="$zone"/></h3>
                    <h4><xsl:value-of select="$imagefile"/></h4>
                
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
                        x: 0.23, /* automatisiert */
                        y: 0.132, /* automatisiert */
                        width: 0.055, /* automatisiert */
                        height: 0.03, /* automatisiert */
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
</xsl:stylesheet>