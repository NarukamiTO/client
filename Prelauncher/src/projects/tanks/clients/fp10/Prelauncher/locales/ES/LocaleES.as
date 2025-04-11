package projects.tanks.clients.fp10.Prelauncher.locales.ES {
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.PartnerLogo.PartnerLogo;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.locales.TextLinkPair;

  public class LocaleES extends Locale {
    public function LocaleES() {
      super();
      this.name = Locales.ES;
      this.playText = "JUGAR";
      this.exitText = "EXIT";
      partners.push(PartnerLogo.FB,"https://facebook.com/TankiOnlineLATAM/");
      partners.push(PartnerLogo.TWITTER,"https://twitter.com/tankionline_lat");
      partners.push(PartnerLogo.YOUTUBE,"https://www.youtube.com/channel/UCslyFVwgmzkh_0H_9Cn2Wqw");
      partners.push(PartnerLogo.INSTAGRAM,"http://www.instagram.com/tankionline_lat");
      partners.push(PartnerLogo.TWITCH,"http://www.twitch.tv/tankionline_latam");
      this.game = new TextLinkPair("Juego","http://tankionline.com/es/");
      this.materials = new TextLinkPair("Recursos","http://tankionline.com/es/media/");
      this.forum = new TextLinkPair("Foro","http://es.tankiforum.com/");
      this.wiki = new TextLinkPair("Wiki","http://es.tankiwiki.com/");
      this.ratings = new TextLinkPair("Clasificaciones","http://ratings.tankionline.com/es/");
      this.help = new TextLinkPair("Ayuda","http://help.tankionline.com/es/");
      this.license = new TextLinkPair("Acuerdo de licencia para el usuario final","http://tankionline.com/es/eula/");
      this.aboutCompany = new TextLinkPair("©2017 Tanki Online Europe Ltd. Todos los derechos reservados.","");
      this.techSupport = new TextLinkPair("Contáctenos para resolver cualquier dificultad:","");
      this.email = new TextLinkPair("support@tankionline.com","mailto:support@tankionline.com");
      this.rules = new TextLinkPair("Reglas del juego","http://tankionline.com/es/rules/");
      this.confidentialityPolicy = new TextLinkPair("Políticas de privacidad y cookies","http://tankionline.com/es/privacy/");
    }
  }
}
