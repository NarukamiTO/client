package projects.tanks.clients.fp10.Prelauncher.locales.DE {
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.PartnerLogo.PartnerLogo;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.locales.TextLinkPair;

  public class LocaleDE extends Locale {
    public function LocaleDE() {
      super();
      this.name = Locales.DE;
      this.playText = "SPIELEN";
      this.exitText = "VERLASSEN";
      partners.push(PartnerLogo.FB,"https://www.facebook.com/TankiOnlineGer");
      partners.push(PartnerLogo.TWITTER,"https://twitter.com/tankionlineger");
      partners.push(PartnerLogo.YOUTUBE,"https://www.youtube.com/channel/UCmvpX0vyEJpYkhxjT8kHZvQ");
      partners.push(PartnerLogo.INSTAGRAM,"http://instagram.com/tankionlineen");
      partners.push(PartnerLogo.GP,"https://plus.google.com/109634410416367176758/");
      partners.push(PartnerLogo.TWITCH,"http://www.twitch.tv/tankistarladderde");
      this.game = new TextLinkPair("Spiel","http://tankionline.com/de/");
      this.materials = new TextLinkPair("Medien","http://tankionline.com/de/media/");
      this.tournaments = new TextLinkPair("Turniere","http://tournament.tankionline.com/de/");
      this.forum = new TextLinkPair("Forum","http://de.tankiforum.com/");
      this.wiki = new TextLinkPair("Wiki","http://de.tankiwiki.com/");
      this.ratings = new TextLinkPair("Ratings","http://ratings.tankionline.com/de/");
      this.help = new TextLinkPair("Hilfe","http://help.tankionline.com/de/");
      this.license = new TextLinkPair("Lizenzvereinbarung","http://tankionline.com/de/eula/");
      this.aboutCompany = new TextLinkPair("©2017 Tanki Online Europe Ltd. Alle Rechte vorbehalten.","");
      this.techSupport = new TextLinkPair("Bei Fragen kontaktieren Sie unseren Support-Dienst:","");
      this.email = new TextLinkPair("help@tankionline.com","mailto:help@tankionline.com");
      this.rules = new TextLinkPair("Regeln","http://tankionline.com/de/rules/");
      this.confidentialityPolicy = new TextLinkPair("Datenschutz- und Cookie-Richtlinien","http://tankionline.com/de/privacy/");
    }
  }
}
