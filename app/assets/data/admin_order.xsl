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

    <form action="/admin/{$key}/info/" method="post" class="form form-admin">
      <input name="authenticity_token" value="&lt;%= form_authenticity_token %>" type="hidden"/>

      <div class="input-group max">
        <input name="information" type="text" class="form-control form-control-sm" value="{Information}"/>
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
          <input type="text" class="form-control form-control-sm" value="{Cost/FullCost}"
                 aria-label="Text input with checkbox"/>
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
          <input type="text" class="form-control" value="{Cost/Prepayment}" aria-label="Text input with radio button"/>
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

    <div class="card admin">
      <div class="card-block">
        <form action="/admin/{$key}/event/" method="post">
          <input type="text" class="form-control form-control-sm" value="{EventName}"/>
          <!--<h6 class="card-subtitle text-muted">-->
          <div class="input-group max">
            od:
            <input type="text" class="col-6 form-control form-control-sm" value="{StartDate}"/>
            do:
            <input type="text" class="col-6 form-control form-control-sm" value="{EndDate}"/>
          </div>
          <!--</h6>-->

          <input type="text" class="form-control form-control-sm" value="{EventAddress/Comment}"/>
          <input type="text" class="form-control form-control-sm" value="{EventAddress/FullAddress/Address}"/>
          <div class="input-group max">

            <input type="text" class="col-3 form-control form-control-sm" value="{EventAddress/FullAddress/Zip}"/>

            <input type="text" class="col-3 form-control form-control-sm" value="{EventAddress/FullAddress/City}"/>
            <input type="text" class="col-3 form-control form-control-sm" value="{EventAddress/FullAddress/State}"/>

            <input type="text" class="col-3 form-control form-control-sm" value="{EventAddress/FullAddress/Country}"/>
          </div>
          <br/>

          <button type="submit" class="btn btn-primary btn-sm pull-right">Zaktualizuj</button>
        </form>
      </div>
    </div>

  </xsl:template>

</xsl:stylesheet>




