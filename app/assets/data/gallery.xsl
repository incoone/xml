<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xsl:output method="html"/>

  <xsl:template match="photos">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css"/>
        <link rel="stylesheet" href="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.css" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.4/jquery.datetimepicker.css" type="text/css" />
      </head>

      <body>
        <nav class="navbar navbar-expand-md navbar-light bg-faded">
          <div class="container">
            <a class="navbar-brand" href="/">Navbar</a>
            <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                  <a class="nav-link" href="/">Strona klienta</a>
                </li>
                <li class="nav-item active">
                  <a class="nav-link" href="http://195.181.219.178:3000/assets/photo.xml">Galeria</a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
        <div class="py-5  section">
          <div class="container">
            <div class="row">
              <div class=".col-sm-4 col-md-offset-4">
                <xsl:for-each select="photo">
                <img src="{@url}" class="img-fluid img-thumbnail" width="500" height="250"/>
                </xsl:for-each>
              </div>
            </div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>