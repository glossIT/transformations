<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xd xsl" version="2.0">
    <xsl:variable name="pathToFolder" select="'C:/Users/krottmas/Desktop/connected/connected/'"/>    
   
    <xsl:variable name="varCollection">
        <xsl:copy-of 
            select="collection(concat('file:///', $pathToFolder, '?select=*.xml;recurse=yes'))
            "/> <!-- [matches(document-uri(.),'AuthorIndex/9[0-9][0-9][0-9]/.*?main.xml')]-->>
    </xsl:variable>

</xsl:stylesheet>
