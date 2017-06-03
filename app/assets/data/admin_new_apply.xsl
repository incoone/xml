<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  <xsl:template match="/">
    <div class="d-inline bg-success">Nowe zgłoszenia:
      <ul>
        <xsl:apply-templates select="//inquiry" />
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="inquiry">
    <xsl:variable name="key" select="@Key"/>
    <xsl:if test="count(//Order[@Key=$key]) &lt; 1">
      <li>..::<a href="/admin/{$key}" class="text-primary"><xsl:value-of select="$key"/> - <xsl:value-of select="name"/></a>::..</li>

    </xsl:if>
  </xsl:template>


</xsl:stylesheet>




