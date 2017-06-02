<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="xx">
    <xsl:call-template name="user_data">
      <xsl:with-param name="key"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:template name="user_data" match="/">
    <div class="container">
      <h4>Zgłoszenie od klienta: <xsl:value-of select="$key"/></h4>
      <!--      <xsl:apply-templates select="//inquiry[contains(@Key, 'WEBW')]"/> -->
      <xsl:apply-templates select="//inquiry[contains(@Key, $key)]"/>

      <h4>Ustalenia:</h4>
      <xsl:apply-templates select="//Order[@Key=$key]"/>
    </div>
    <hr/>
    <p>stwórz nowy event bądź uzupełnij formatkę kontaktu</p>
    <div class="container home">
      <div class="card admin">
        <div class="card-block">
          <form action="/admin/{$key}/eventAdd/" method="post">

            <input name="EventName" type="text" class="form-control form-control-sm" placeholder="nazwa eventu"/>
            <hr/>
            <div class="input-group max">
              od:
              <input name="StartDate" type="text" class="col-6 form-control form-control-sm" placeholder="/2017-06-12T08:00:00/"/>
              do:
              <input name="EndDate" type="text" class="col-6 form-control form-control-sm" placeholder="/2017-06-12T08:00:00/"/>
            </div>
            <hr/>
            <input name="EComment" type="text" class="form-control form-control-sm" placeholder="opis miejsca"/>
            <input name="EFAddress" type="text" class="form-control form-control-sm" placeholder="ulica"/>
            <div class="input-group max">
              <input name="EFZip" type="text" class="col-3 form-control form-control-sm"
                     placeholder="ZIP"/>
              <input name="EFCity" type="text" class="col-3 form-control form-control-sm"
                     placeholder="miasto"/>
              <input name="EFState" type="text" class="col-3 form-control form-control-sm"
                     placeholder="województwo"/>
              <input name="EFCountry" type="text" class="col-3 form-control form-control-sm"
                     placeholder="państwo"/>
            </div>
            <br/>

            <button type="submit" class="btn btn-success pull-right">Dodaj nową kartę eventu</button>
            <input name="authenticity_token" value="&lt;%= form_authenticity_token %>" type="hidden"/>
          </form>
        </div>
      </div>

      <div class="card admin">
        <div class="card-block">
          <form action="/admin/{$key}/customerAdd/" method="post">
            <input name="authenticity_token" value="&lt;%= form_authenticity_token %>" type="hidden"/>
            <div class="input-group max">
              <input name="FName" type="text" class="col-6 form-control form-control-sm" placeholder="imie"/>
              <input name="LName" type="text" class="col-6 form-control form-control-sm" placeholder="nazwisko"/>
            </div>
            <div class="input-group max">
              <input name="CompanyName" type="text" class="col-8 form-control form-control-sm" placeholder="firma"/>
              <input name="TaxNo" type="text" class="col-4 form-control form-control-sm" placeholder="NIP"/>
            </div>
            <hr/>
            <input name="Address" type="text" class="form-control form-control-sm" placeholder="ulica"/>
            <div class="input-group max">
              <input name="Zip" type="text" class="col-4 form-control form-control-sm" placeholder="ZIP"/>
              <input name="City" type="text" class="col-4 form-control form-control-sm" placeholder="miasto"/>
            </div>
            <div class="input-group max">
              <input name="State" type="text" class="col-4 form-control form-control-sm" placeholder="województwo"/>
              <input name="Country" type="text" class="col-4 form-control form-control-sm" placeholder="państwo"/>
            </div>
            <hr/>
            <div class="input-group max">
              <input name="TelNo" type="text" class="col-8 form-control form-control-sm" placeholder="telefon"/>
              <input name="Mail" type="text" class="col-4 form-control form-control-sm" placeholder="mail"/>
            </div>

            <hr/>
            <button type="submit" class="btn btn-success pull-right">Dodaj nową kartę kontaktu</button>
          </form>
        </div>
      </div>
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
            <xsl:if test="/Cost/Invoice='TAK'">
              <input name="Invoice" checked="checked" type="checkbox" aria-label="faktura?"/>
            </xsl:if>

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
      <xsl:apply-templates select="Customer"/>
    </div>
  </xsl:template>

  <xsl:template match="Customer">
    <div class="card admin">
      <div class="card-block">
        <form action="/admin/{$key}/customer/" method="post">
          <input name="uuid" value="{@uuid}" type="hidden"/>
          <input name="authenticity_token" value="&lt;%= form_authenticity_token %>" type="hidden"/>
          <div class="input-group max">
            <input name="FName" type="text" class="col-6 form-control form-control-sm" value="{CustomerName/FName}"
                   placeholder="imie"/>
            <input name="LName" type="text" class="col-6 form-control form-control-sm" value="{CustomerName/LName}"
                   placeholder="nazwisko"/>
          </div>
          <div class="input-group max">
            <input name="CompanyName" type="text" class="col-8 form-control form-control-sm"
                   value="{Company/CompanyName}" placeholder="firma"/>
            <input name="TaxNo" type="text" class="col-4 form-control form-control-sm" value="{Company/TaxNo}"
                   placeholder="NIP"/>
          </div>
          <hr/>
          <input name="Address" type="text" class="form-control form-control-sm" value="{FullAddress/Address}"
                 placeholder="ulica"/>
          <div class="input-group max">
            <input name="Zip" type="text" class="col-4 form-control form-control-sm" value="{FullAddress/Zip}"
                   placeholder="ZIP"/>
            <input name="City" type="text" class="col-4 form-control form-control-sm" value="{FullAddress/City}"
                   placeholder="miasto"/>
          </div>
          <div class="input-group max">
            <input name="State" type="text" class="col-4 form-control form-control-sm" value="{FullAddress/State}"
                   placeholder="województwo"/>
            <input name="Country" type="text" class="col-4 form-control form-control-sm" value="{FullAddress/Country}"
                   placeholder="państwo"/>
          </div>
          <hr/>
          <div class="input-group max">
            <input name="TelNo" type="text" class="col-8 form-control form-control-sm" value="{TelNo}"
                   placeholder="telefon"/>
            <input name="Mail" type="text" class="col-4 form-control form-control-sm" value="{Mail}"
                   placeholder="mail"/>
          </div>

          <hr/>
          <button type="submit" class="btn btn-primary pull-right">Zaktualizuj</button>
        </form>
        <form action="/admin/{$key}/customerDel/" method="post">
          <input name="uuid" value="{@uuid}" type="hidden"/>
          <input name="authenticity_token" value="&lt;%= form_authenticity_token %>" type="hidden"/>
          <button type="submit" class="btn btn-danger btn-sm">USUŃ</button>
        </form>

      </div>
    </div>
  </xsl:template>


  <xsl:template match="Event">

    <div class="card admin">
      <div class="card-block">
        <form action="/admin/{$key}/event/" method="post">
          <input name="uuid" value="{@uuid}" type="hidden"/>
          <input name="authenticity_token" value="&lt;%= form_authenticity_token %>" type="hidden"/>
          <input name="EventName" type="text" class="form-control form-control-sm" value="{EventName}"
                 placeholder="nazwa eventu"/>
          <hr/>
          <div class="input-group max">
            od:
            <input name="StartDate" type="text" class="col-6 form-control form-control-sm" value="{StartDate}"
                   placeholder="/2017-06-12T08:00:00/"/>
            do:
            <input name="EndDate" type="text" class="col-6 form-control form-control-sm" value="{EndDate}"
                   placeholder="/2017-06-12T08:00:00/"/>
          </div>
          <hr/>

          <input name="EComment" type="text" class="form-control form-control-sm" value="{EventAddress/Comment}"
                 placeholder="opis miejsca"/>
          <input name="EFAddress" type="text" class="form-control form-control-sm"
                 value="{EventAddress/FullAddress/Address}" placeholder="ulica"/>
          <div class="input-group max">
            <input name="EFZip" type="text" class="col-3 form-control form-control-sm"
                   value="{EventAddress/FullAddress/Zip}" placeholder="ZIP"/>
            <input name="EFCity" type="text" class="col-3 form-control form-control-sm"
                   value="{EventAddress/FullAddress/City}" placeholder="miasto"/>
            <input name="EFState" type="text" class="col-3 form-control form-control-sm"
                   value="{EventAddress/FullAddress/State}" placeholder="województwo"/>
            <input name="EFCountry" type="text" class="col-3 form-control form-control-sm"
                   value="{EventAddress/FullAddress/Country}" placeholder="państwo"/>
          </div>
          <br/>

          <button type="submit" class="btn btn-primary pull-right">Zaktualizuj</button>
        </form>
        <form action="/admin/{$key}/eventDel/" method="post">
          <input name="uuid" value="{@uuid}" type="hidden"/>
          <input name="authenticity_token" value="&lt;%= form_authenticity_token %>" type="hidden"/>
          <button type="submit" class="btn btn-danger btn-sm">USUŃ</button>
        </form>
      </div>
    </div>

  </xsl:template>



</xsl:stylesheet>




