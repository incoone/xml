<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="user_data" match="/">
    <div class="container">
      <div class="row">
        <div class="timeline-centered">
          <xsl:apply-templates select="//Order"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="Order">
    <article class="timeline-entry">

      <div class="timeline-entry-inner">

        <div class="timeline-icon bg-success">
          <i class="entypo-feather"></i>
        </div>

        <div class="timeline-label">
          <h2><a href="/admin/{@Key}/"><xsl:value-of select="@Key"/></a> <span><xsl:value-of select="Information"/></span></h2>
          <p>Tolerably earnestly middleton extremely distrusts she boy now not. Add and offered prepare how cordial two promise. Greatly who affixed suppose but enquire compact prepare all put. Added forth chief trees but rooms think may.</p>
        </div>
      </div>

    </article>

  </xsl:template>

</xsl:stylesheet>

