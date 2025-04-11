package projects.tanks.clients.fp10.Prelauncher.locales.EN {
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.PartnerLogo.PartnerLogo;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.locales.TextLinkPair;

  public class LocaleEn extends Locale {
    public function LocaleEn() {
      super();
      this.name = Locales.EN;
      this.playText = "PLAY";
      this.exitText = "EXIT";
      partners.push(PartnerLogo.FB,"https://www.facebook.com/TankiOnline.en");
      partners.push(PartnerLogo.TWITTER,"https://twitter.com/tankionlineen");
      partners.push(PartnerLogo.YOUTUBE,"http://www.youtube.com/user/tankionlineint");
      partners.push(PartnerLogo.INSTAGRAM,"http://instagram.com/tankionlineen");
      partners.push(PartnerLogo.GP,"https://plus.google.com/+tankionlineint/");
      partners.push(PartnerLogo.TWITCH,"http://www.twitch.tv/tankistarladder_en");
      this.game = new TextLinkPair("Game","http://tankionline.com/en/");
      this.materials = new TextLinkPair("Materials","http://tankionline.com/en/media/");
      this.tournaments = new TextLinkPair("Tournament","http://tournament.tankionline.com/en/");
      this.forum = new TextLinkPair("Forum","http://en.tankiforum.com/");
      this.wiki = new TextLinkPair("Wiki","http://en.tankiwiki.com/");
      this.ratings = new TextLinkPair("Ratings","http://ratings.tankionline.com/en/");
      this.help = new TextLinkPair("Help","http://help.tankionline.com/en/");
      this.license = new TextLinkPair("EULA","http://tankionline.com/en/eula/");
      this.aboutCompany = new TextLinkPair("©2017 Tanki Online Europe Ltd. All rights reserved.","");
      this.techSupport = new TextLinkPair("Contact us regarding any issues:","");
      this.email = new TextLinkPair("help@tankionline.com","mailto:help@tankionline.com");
      this.rules = new TextLinkPair("Rules","http://tankionline.com/en/rules/");
      this.confidentialityPolicy = new TextLinkPair("Privacy policy","http://tankionline.com/en/privacy/");
    }
  }
}
