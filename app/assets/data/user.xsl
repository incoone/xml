<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="xx">
    <xsl:call-template name="user_data">
      <xsl:with-param name="main_phone" />
      <xsl:with-param name="key" />
      <xsl:with-param name="treedoc"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:template name="user_data" match="/">

    <div class="py-5">
      <div class="container home">
        <!-- <xsl:apply-templates select="//Order[@Key=$key]/Event" /> -->
        <xsl:apply-templates select="//Order[@Key=$key and Customer/TelNo=$main_phone]" />

        <xsl:if test="count(//Order[@Key=$key and Customer/TelNo=$main_phone]/Event) &lt; 1">
          <xsl:choose>
            <xsl:when test="count(//inquiry[@Key=$key and phone=$main_phone]) &lt; 1">
              <div class="bg-danger text-white">
                Pod wskazanym numerem telefonu oraz kluczu nie znaleźliśmy Twojego zgłoszenia.
              </div>
            </xsl:when>
            <xsl:otherwise>
              <div class="bg-warning text-white">
                Dziekujemy za zgłoszenie, bedziemy kontaktować się telefonicznie w celu ustalenia szczegółów.<br/>
                Dopiero wtedy na tej stronie pojawi się podsumowanie umowy na usługi fotograficzne.
              </div>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="inquiry">
    <xsl:value-of select="mail"/><br/>
  </xsl:template>

  <xsl:template match="Order">
    <xsl:apply-templates select="Customer"/>
    <xsl:apply-templates select="Event"/>
  </xsl:template>

  <xsl:template match="Event">
   <!-- <div class="row">-->
      <!--<div class="col-md-6">-->
        <div class="card home">
          <div class="card-block">
            <h4 class="card-title"><xsl:value-of select="EventName"/></h4>
            <h6 class="card-subtitle text-muted">
              <xsl:value-of select="StartDate"/> - <xsl:value-of select="EndDate"/>
            </h6>
            <p class="card-text p-y-1">
              <xsl:value-of select="EventAddress/Comment"/><br/>
              <xsl:value-of select="EventAddress/FullAddress/Address"/>,
              <xsl:value-of select="EventAddress/FullAddress/City"/>

            </p>
            <a href="#" class="card-link">link</a>
          </div>
        </div>
    <!--</div>-->
    <!--</div>-->
  </xsl:template>

  <xsl:template match="Customer">
    <!-- <div class="row">-->
    <!--<div class="col-md-6">-->
    <div class="card home">
      <div class="card-block">
        <h4 class="card-title">
          <xsl:value-of select="CustomerName/FName"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="CustomerName/LName"/>
        </h4>
        <p class="card-text p-y-1">
          <xsl:text>Tel: </xsl:text><xsl:value-of select="TelNo"/><br/>
          <xsl:text>Email: </xsl:text><xsl:value-of select="Mail"/><br/>
          <xsl:value-of select="FullAddress/Country"/>
          <xsl:text>, województwo </xsl:text>
          <xsl:value-of select="FullAddress/State"/><br/>
          <xsl:value-of select="FullAddress/City"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="FullAddress/Zip"/><br/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="FullAddress/Address"/><br/>
        </p>
    <!--<a href="#" class="card-link">link</a>-->
    <!--<a href="#" class="card-link">Second link</a>-->
    </div>
  </div>
<!--</div>-->
    <!--</div>-->
  </xsl:template>
</xsl:stylesheet>




