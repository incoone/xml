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

        <xsl:choose>
          <xsl:when test="Cost/FullCost - Cost/Prepayment = 0">
            <div class="timeline-icon bg-success">
              <i class="entypo-feather"></i>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <div class="timeline-icon bg-danger">
              <i class="entypo-feather"></i>
            </div>
          </xsl:otherwise>
        </xsl:choose>


        <div class="timeline-label">
          <h2>
            <a href="/admin/{@Key}/">
              <xsl:value-of select="@Key"/>
            </a>
            <span>
              <xsl:value-of select="Information"/>
            </span>

            <xsl:if test="Cost/FullCost - Cost/Prepayment > 0">
              <br/>
              <span>
                (Klient ma do uregulowania jeszcze:
                <xsl:value-of select="Cost/FullCost - Cost/Prepayment"/>
                <xsl:value-of select="Cost/@Currency"/>)
              </span>
            </xsl:if>

          </h2>
            <xsl:apply-templates select="Customer"/>
          <br/>
          <xsl:apply-templates select="Event"/>
        </div>
      </div>
    </article>
  </xsl:template>

  <xsl:template match="Customer">
    <p>
      <xsl:value-of select="CustomerName/FName"/>
      .
      <xsl:value-of select="CustomerName/LName"/>
      , telefon:
      <xsl:value-of select="TelNo"/>
      , mail:
      <xsl:value-of select="Mail"/>
    </p>
  </xsl:template>

  <xsl:template match="Event">
    <p>
      <xsl:value-of select="EventName"/>
      ,
      <xsl:value-of select="StartDate"/>
      ,
      <xsl:value-of select="EventAddress/Comment"/>
      ,
      <xsl:value-of select="EventAddress/FullAddress/City"/>
    </p>
  </xsl:template>

</xsl:stylesheet>

