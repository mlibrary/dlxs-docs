<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="DLPSDOC">
        <xsl:processing-instruction name="cocoon-format">type=&quot;text/html&quot;</xsl:processing-instruction>
        <HTML>
              <HEAD>
              <LINK HREF="http://www.umdl.umich.edu/dlps-docs.css" REL="STYLESHEET" TYPE="text/css"/>
               <xsl:text>&#10;</xsl:text>
            <TITLE>
                <xsl:apply-templates select="TITLE"/>
            </TITLE>
            <xsl:element name="style">
                <xsl:text>&#10;</xsl:text>
 <xsl:comment>
 .header {margin-top:10px}
 </xsl:comment>
              <xsl:text>&#10;</xsl:text>
            </xsl:element>
              </HEAD>
               <xsl:text>&#10;</xsl:text>
       <xsl:element name="BODY">
       <xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
       <xsl:attribute name="topmargin">0</xsl:attribute>
       <xsl:attribute name="marginwidth">0</xsl:attribute>
       <xsl:attribute name="marginheight">0</xsl:attribute>
       <xsl:attribute name="background">http://dlxs.org/images/dlxs2ndlvlbkgndC.gif</xsl:attribute>
          <xsl:apply-templates select="HEADER"/>
          <xsl:apply-templates select="BODY"/>
      </xsl:element>    
        </HTML>      
    </xsl:template>  
 
 
 <xsl:template match="HEADER">
     <xsl:text>&#10;</xsl:text> 
       <table border="0" cellspacing="0" cellpadding="0" width="590"> 
           <xsl:text>&#10;</xsl:text>
         <tbody>
         <tr>
           <td width="123" align="left" valign="top" height="43"><a href="http://dlxs.org"><img src="http://dlxs.org/images/dlxslogo_01.gif" width="123" height="43" border="0"/></a></td>
            <xsl:text>&#10;</xsl:text>
           <td align="center" width="332" height="20"><img src="http://dlxs.org/images/dlxstopspace_02.gif" name="Image1" width="482" height="20" border="0"/></td>
         <tr>
           <td align="center"><STRONG><A class="navlink" HREF="http://docs.dlxs.org/search.html">Search DLXS Documentation</A></STRONG></td>
       </tr>
       <xsl:text>&#10;</xsl:text>
         </tr>
         </tbody>
          <xsl:text>&#10;</xsl:text>
     </table> <xsl:text>&#10;</xsl:text>
        <xsl:element name="DIV">
          <xsl:attribute name="class">header</xsl:attribute> <xsl:text>&#10;</xsl:text>
          <table border="1" cellspacing="1" cellpadding="4">
            <tbody>
                <xsl:apply-templates/>
            </tbody>
        </table> <xsl:text>&#10;</xsl:text>
        </xsl:element>  
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    <xsl:template match="JOURNAL">
        <TR>
            <TD>
                <B>Resource:</B>
            </TD>
            <TD>
                <xsl:apply-templates/>
            </TD>
        </TR>
    </xsl:template>
    <xsl:template match="PUBDATE">
        <TR>
            <TD>
                <B>Date of Publication:</B>
            </TD>
            <TD>
                <xsl:apply-templates/>
            </TD>
        </TR>
    </xsl:template>
    <xsl:template match="AUTH1">
        <TR>
            <TD>
                <B>Author:</B>
            </TD>
            <TD>
                <xsl:choose>
                    <xsl:when test="//EMAIL1">
                        <xsl:element name="A">
                            <xsl:attribute name="href">
                                <xsl:text>mailto:</xsl:text>
                                <xsl:value-of select="//EMAIL1"/>
                            </xsl:attribute>
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </TD>
        </TR>
    </xsl:template>
    <xsl:template match="AUTH2">
        <TR>
            <TD>
                <B>Author:</B>
            </TD>
            <TD>
                <xsl:choose>
                    <xsl:when test="//EMAIL2">
                        <xsl:element name="A">
                            <xsl:attribute name="href">
                                <xsl:text>mailto:</xsl:text>
                                <xsl:value-of select="//EMAIL2"/>
                            </xsl:attribute>
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </TD>
        </TR>
    </xsl:template>
    <xsl:template match="EMAIL1"/>
    <xsl:template match="EMAIL2"/>
    <xsl:template match="DOCTITLE">
        <TR>
            <TD>
                <B>Document title:</B>
            </TD>
            <TD>
                <xsl:apply-templates/>
            </TD>
        </TR>
    </xsl:template>
    <xsl:template match="VOL">
        <TR>
            <TD>
                <B>Section:</B>
            </TD>
            <TD>
                <xsl:apply-templates/>
            </TD>
        </TR>
    </xsl:template>
    <xsl:template match="ISS">
        <TR>
            <TD>
                <B>Subsection:</B>
            </TD>
            <TD>
                <xsl:apply-templates/>
            </TD>
        </TR>
    </xsl:template>
    <xsl:template match="FILE">
        <TR>
            <TD>
                <B>FILE ID:</B>
            </TD>
            <TD>
                <xsl:apply-templates/>
            </TD>
        </TR>
    </xsl:template>
      <xsl:template match="BODY">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="BHEAD">
        <H1 ALIGN="center">
            <xsl:apply-templates/>
        </H1>
    </xsl:template>
    <xsl:template match="DIV1">
        <xsl:element name="DIV">
            <xsl:attribute name="CLASS">level1</xsl:attribute>
            <xsl:choose>
                <xsl:when test="@ID">
                    <xsl:element name="a">
                        <xsl:attribute name="name">
                            <xsl:value-of select="@ID"/>
                        </xsl:attribute>
                        <xsl:text/>
                    </xsl:element>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template match="DIV2">
        <xsl:element name="DIV">
            <xsl:attribute name="CLASS">level2</xsl:attribute>
            <xsl:choose>
                <xsl:when test="@ID">
                    <xsl:element name="a">
                        <xsl:attribute name="name">
                            <xsl:value-of select="@ID"/>
                        </xsl:attribute>
                        <xsl:text/>
                    </xsl:element>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template match="DIV3">
        <xsl:element name="DIV">
            <xsl:attribute name="CLASS">level3</xsl:attribute>
            <xsl:choose>
                <xsl:when test="@ID">
                    <xsl:element name="a">
                        <xsl:attribute name="name">
                            <xsl:value-of select="@ID"/>
                        </xsl:attribute>
                        <xsl:text/>
                    </xsl:element>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template match="DIV4">
        <xsl:element name="DIV">
            <xsl:attribute name="CLASS">level4</xsl:attribute>
            <xsl:choose>
                <xsl:when test="@ID">
                    <xsl:element name="a">
                        <xsl:attribute name="name">
                            <xsl:value-of select="@ID"/>
                        </xsl:attribute>
                        <xsl:text/>
                    </xsl:element>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template match="DIV5">
        <xsl:element name="DIV">
            <xsl:attribute name="CLASS">level5</xsl:attribute>
            <xsl:choose>
                <xsl:when test="@ID">
                    <xsl:element name="a">
                        <xsl:attribute name="name">
                            <xsl:value-of select="@ID"/>
                        </xsl:attribute>
                        <xsl:text/>
                    </xsl:element>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template match="SPAN">
        <xsl:choose>
            <xsl:when test="@ID">
                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@ID"/>
                    </xsl:attribute>
                    <xsl:text/>
                </xsl:element>
                <xsl:copy>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--
looks like we don't need this any more
  <xsl:template match="TABLE">
   <TABLE BORDER="1">
    <xsl:apply-templates/>
   </TABLE>
  </xsl:template>
-->
    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
     <xsl:template match="TITLE">
      <xsl:copy-of select="node()"/>
     </xsl:template>  
     
        <xsl:template match="BODY">
      <xsl:apply-templates/>
    </xsl:template>  
    
</xsl:stylesheet>

 
