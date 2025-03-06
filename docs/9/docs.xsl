<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="DLPSDOC">
   <xsl:processing-instruction name="cocoon-format">type="text/html"</xsl:processing-instruction>
   <HTML>
<LINK REL="STYLESHEET" TYPE="text/css" HREF="http://www.umdl.umich.edu/dlps-docs.css"/>
     <xsl:apply-templates/>
   </HTML>
  </xsl:template>

  <xsl:template match="TITLE">
   <HEAD><TITLE>
    <xsl:apply-templates/>
   </TITLE></HEAD>
  </xsl:template>





  <xsl:template match="HEADER">
   <TABLE BORDER="1"><TBODY>
    <xsl:apply-templates/>
   </TBODY></TABLE><HR WIDTH="25%"></HR>
  </xsl:template>


  <xsl:template match="JOURNAL">
   <TR><TD><B>Resource:</B></TD><TD>
    <xsl:apply-templates/>
   </TD></TR>
  </xsl:template>

  <xsl:template match="PUBDATE">
   <TR><TD><B>Date of Publication:</B></TD><TD>
    <xsl:apply-templates/>
   </TD></TR>
  </xsl:template>

  <xsl:template match="AUTH1">
   <TR><TD><B>Author:</B></TD><TD>
    <xsl:apply-templates/>
   </TD></TR>
  </xsl:template>

  <xsl:template match="AUTH2">
   <TR><TD><B>Author:</B></TD><TD>
    <xsl:apply-templates/>
   </TD></TR>
  </xsl:template>

  <xsl:template match="DOCTITLE">
   <TR><TD><B>Document title:</B></TD><TD>
    <xsl:apply-templates/>
   </TD></TR>
  </xsl:template>

  <xsl:template match="VOL">
   <TR><TD><B>Section:</B></TD><TD>
    <xsl:apply-templates/>
   </TD></TR>
  </xsl:template>

  <xsl:template match="ISS">
   <TR><TD><B>Subsection:</B></TD><TD>
    <xsl:apply-templates/>
   </TD></TR>
  </xsl:template>

  <xsl:template match="FILE">
   <TR><TD><B>FILE ID:</B></TD><TD>
    <xsl:apply-templates/>
   </TD></TR>
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
	  <xsl:attribute name="name"><xsl:value-of select="@ID"/></xsl:attribute>
	  <xsl:text> </xsl:text>
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
	  <xsl:attribute name="name"><xsl:value-of select="@ID"/></xsl:attribute>
	  <xsl:text> </xsl:text>
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
	  <xsl:attribute name="name"><xsl:value-of select="@ID"/></xsl:attribute>
	  <xsl:text> </xsl:text>
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
	  <xsl:attribute name="name"><xsl:value-of select="@ID"/></xsl:attribute>
	  <xsl:text> </xsl:text>
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
	  <xsl:attribute name="name"><xsl:value-of select="@ID"/></xsl:attribute>
	  <xsl:text> </xsl:text>
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
	  <xsl:attribute name="name"><xsl:value-of select="@ID"/></xsl:attribute>
	  <xsl:text> </xsl:text>
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

</xsl:stylesheet>
