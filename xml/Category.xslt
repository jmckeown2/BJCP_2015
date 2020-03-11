<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="stylesheet" href="Category.css"/>
    </head>
    <body>
        <xsl:apply-templates match="category"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="category">
    <h1><xsl:value-of select="@number"/> &#8212; <xsl:value-of select="@name"/></h1>
    <p><xsl:value-of select="paragraph"/></p>
    <xsl:apply-templates select="style"/>
</xsl:template>

<xsl:template match="style">
    <article class="beerstyle">
    <section class="rawstyle">
        <h2><xsl:value-of select="@style_id"/> &#8212; <xsl:value-of select="@style_name"/></h2>
        <xsl:call-template name="stylebody"/>
    </section>
    <xsl:apply-templates select="substyle">
        <xsl:with-param name="style_id" select="@style_id"/>
    </xsl:apply-templates>
    </article>
</xsl:template>

<xsl:template match="substyle">
    <xsl:param name="style_id"/>
    <section class="beersubstyle">
        <h2><xsl:value-of select="$style_id"/> &#8212; <xsl:value-of select="@style_name"/> / <xsl:value-of select="@substyle_name"/></h2>
        <xsl:call-template name="stylebody"/>
    </section>
</xsl:template>

<xsl:template name="stylebody">
    <article class="main">
        <xsl:apply-templates select="overallimpression"/>
        <xsl:apply-templates select="appearance"/>
        <xsl:apply-templates select="aroma"/>
        <xsl:apply-templates select="flavor"/>
        <xsl:apply-templates select="mouthfeel"/>
        <xsl:apply-templates select="comments"/>
        <xsl:apply-templates select="history"/>
        <xsl:apply-templates select="characteristicingredients"/>
        <xsl:apply-templates select="stylecomparison"/>
        <xsl:apply-templates select="entryinstructions"/>
        <xsl:if test="paragraph">
            <h3>Other Notes</h3>
            <xsl:for-each select="paragraph">
                <p><xsl:value-of select="." /></p>
            </xsl:for-each>
        </xsl:if>
    </article>
    <article class="right">
        <xsl:apply-templates select="vitalstatistics"/>
        <xsl:apply-templates select="commercialexamples"/>
        <xsl:apply-templates select="tags"/>
    </article>
</xsl:template>

<xsl:template match="overallimpression">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'Overall Impression'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="appearance">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'Apperance'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="aroma">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'Aroma'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="flavor">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'Flavor'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="mouthfeel">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'Mouthfeel'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="comments">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'Comments'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="history">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'History'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="characteristicingredients">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'Characteristic Ingredients'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="stylecomparison">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'Style Comparison'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="entryinstructions">
    <xsl:call-template name="h3AndPara">
        <xsl:with-param name="h3" select="'Entry Instructions'"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="vitalstatistics">
    <h3>Vital Statistics</h3>
    <xsl:if test="OG">
    <table class="vitalstatistics">
        <tr>
            <th>IBU:</th>
            <td><xsl:apply-templates select="IBUs" mode="range"/></td>
        </tr>
        <tr>
            <th>SRM:</th>
            <td><xsl:apply-templates select="SRM" mode="range"/></td>
        </tr>
        <tr>
            <th>OG:</th>
            <td><xsl:apply-templates select="OG" mode="range"/></td>
        </tr>
        <tr>
            <th>FG:</th>
            <td><xsl:apply-templates select="FG" mode="range"/></td>
        </tr>
        <tr>
            <th>ABV:</th>
            <td><xsl:apply-templates select="ABV" mode="range"/></td>
        </tr>
    </table>
    </xsl:if>
    <xsl:for-each select="paragraph">
        <p><xsl:value-of select="." /></p>
    </xsl:for-each>
</xsl:template>


<xsl:template match="commercialexamples">
    <h3>Commercial Examples</h3>
    <ul class="commercialexamples">
        <xsl:for-each select="commercial_example">
            <li><xsl:value-of select="." /></li>
        </xsl:for-each>
    </ul>
</xsl:template>

<xsl:template match="tags">
    <h3>Tags</h3>
    <p>
        <xsl:for-each select="tag">
            <xsl:value-of select="."/>
            <xsl:if test="position() != last()">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:for-each>
    </p>
</xsl:template>

<xsl:template match = "*" mode="range">
    <xsl:value-of select="@low"/>
    <xsl:text> - </xsl:text>
    <xsl:value-of select="@high"/>
</xsl:template>


<xsl:template name="h3AndPara">
    <xsl:param name="h3"/>
    <xsl:param name="para" select="."/>
    <h3><xsl:value-of select="$h3"/></h3>
    <p><xsl:value-of select="$para"/></p>
</xsl:template>

</xsl:stylesheet>