package projects.tanks.clients.fp10.Prelauncher.locales.PL {
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.PartnerLogo.PartnerLogo;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.locales.TextLinkPair;

  public class LocalePL extends Locale {
    public function LocalePL() {
      super();
      this.name = Locales.PL;
      this.playText = "GRAJ";
      this.exitText = "EXIT";
      partners.push(PartnerLogo.FB,"https://www.facebook.com/tankionlinePL");
      partners.push(PartnerLogo.TWITTER,"https://twitter.com/tankionline_pl");
      partners.push(PartnerLogo.YOUTUBE,"http://www.youtube.com/user/tankionlineint");
      partners.push(PartnerLogo.GP,"https://plus.google.com/117578038296214026926/posts");
      this.game = new TextLinkPair("Gra","http://tankionline.com/pl/");
      this.materials = new TextLinkPair("Materiały","http://tankionline.com/pl/media/");
      this.forum = new TextLinkPair("Forum","http://pl.tankiforum.com/");
      this.wiki = new TextLinkPair("Wiki","http://pl.tankiwiki.com/");
      this.ratings = new TextLinkPair("Rankingi","http://ratings.tankionline.com/pl/");
      this.help = new TextLinkPair("Pomoc","http://help.tankionline.com/pl/");
      this.license = new TextLinkPair("Umowa Licencyjna Użytkownika Oprogramowania","http://tankionline.com/pl/eula/");
      this.aboutCompany = new TextLinkPair("©2017 Tanki Online Europe Ltd. Wszystkie prawa zastrzeżone.","");
      this.techSupport = new TextLinkPair("W razie jakichkolwiek problemów skontaktuj się z nami:","");
      this.email = new TextLinkPair("help@tankionline.com","mailto:help@tankionline.com");
      this.rules = new TextLinkPair("Zasady Gry","http://tankionline.com/pl/rules/");
      this.confidentialityPolicy = new TextLinkPair("Polityka prywatności i pliki cookies","http://tankionline.com/pl/privacy/");
    }
  }
}
