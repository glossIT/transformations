<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="* | @*">
        
        <!-- Copy All -->
        <xsl:copy>           
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
   
    
    <xsl:template match="/t:pb[1]">      
        <xsl:result-document href="../../../../../GitHub/"> 
           <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <script src="../OSD/OSD/openseadragon.js" type="text/javascript"><xsl:text> </xsl:text></script>               
                <title>Offline OSD Viewer with Overlay</title>
            </head>
            <body>
                <h2>Manuscript Viewer</h2>            
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
                    }
                    
                    <script type="text/javascript">
                        
                        OpenSeadragon({
                        id:            "image",
                        prefixUrl:     "../OSD/OSD/images/",
                        tileSources: [{          
                        type: 'image',
                        url: "https://www.cats.org.uk/media/13136/220325case013.jpg" /*parameter*/ 
                        ,
                        overlays: [{
                        id: 'overlay',
                        x: 0.23, /* automatisiert */
                        y: 0.132, /* automatisiert */
                        width: 0.055, /* automatisiert */
                        height: 0.03, /* automatisiert */
                        className: 'highlight'
                        }]
                        
                        }],
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