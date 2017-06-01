<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="xx">
    <xsl:call-template name="user_data">
      <xsl:with-param name="key"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:template name="user_data" match="/">
    <div class="container">
      <h4>Zgłoszenie od klienta:</h4>
      <br/>
      <xsl:apply-templates select="//inquiry[@Key=$key]"/>
      <h4>Ustalenia:</h4>
      <xsl:apply-templates select="//Order[@Key=$key]"/>
    </div>
  </xsl:template>

  <xsl:template match="inquiry">
    <table>
      <tr>
        <td>mail:</td>
        <td>
          <xsl:value-of select="mail"/>
        </td>
      </tr>
      <tr>
        <td>imie nazwisko:</td>
        <td>
          <xsl:value-of select="name"/>
        </td>
      </tr>
      <tr>
        <td>telefon</td>
        <td>
          <xsl:value-of select="phone"/>
        </td>
      </tr>
      <tr>
        <td>data</td>
        <td>
          <xsl:value-of select="date"/>
        </td>
      </tr>
      <tr>
        <td>komentarz</td>
        <td>
          <xsl:value-of select="comment"/>
        </td>
      </tr>
      <tr>
        <td>wybrany pakiet</td>
        <td>
          <xsl:value-of select="package"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="Order">

    <form class="form form-admin">
      <div class="input-group max">
        <input type="text" class="form-control form-control-sm" value="{Information}"/>
        <button type="submit" class="btn btn-primary btn-sm ">Zaktualizuj</button>
      </div>
    </form>

    <div class="row form-admin">
      <div class="col-lg-6">
        <div class="input-group">
          <span class="input-group-addon input-group-addon-sm">faktura?
            <input type="checkbox" aria-label="faktura?"/>
          </span>
          <span class="input-group-addon input-group-addon-sm">kwota za całość:</span>
          <input type="text" class="form-control form-control-sm" aria-label="Text input with checkbox"/>
          <select class="custom-select mb-2 mr-sm-2 mb-sm-0" id="inlineFormCustomSelect">
            <option value="PLN" selected="selected">PLN</option>
            <option value="USD">USD</option>
            <option value="EUR">EUR</option>
          </select>
        </div>
      </div>
      <div class="col-lg-4">
        <div class="input-group">
          <span class="input-group-addon">zapłacono:</span>
          <input type="text" class="form-control" aria-label="Text input with radio button"/>
        </div>
      </div>
      <div class="col-lg-2">
        <button type="submit" class="btn btn-primary btn-sm pull-right">Zaktualizuj</button>
      </div>
    </div>
    <hr/>
    <div class="container home">
      <xsl:apply-templates select="Event"/>
    </div>

  </xsl:template>

  <xsl:template match="Event">
    <!-- <div class="row">-->
    <!--<div class="col-md-6">-->
    <div class="card admin">
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
        <a href="#" class="card-link">Second link</a>
      </div>
    </div>
    <!--</div>-->
    <!--</div>-->
  </xsl:template>

</xsl:stylesheet>




