package projects.tanks.clients.fp10.Prelauncher.locales.BR {
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.PartnerLogo.PartnerLogo;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.locales.TextLinkPair;

  public class LocaleBR extends Locale {
    public function LocaleBR() {
      super();
      this.name = Locales.BR;
      this.playText = "JOGUE";
      this.exitText = "EXIT";
      partners.push(PartnerLogo.FB,"https://www.facebook.com/tankionlineptbr");
      partners.push(PartnerLogo.TWITTER,"https://twitter.com/tankionlinebr");
      partners.push(PartnerLogo.YOUTUBE,"http://www.youtube.com/TankiOnlinePTBR");
      partners.push(PartnerLogo.GP,"https://plus.google.com/u/0/115456110754420916823/posts");
      this.game = new TextLinkPair("Jogo","http://tankionline.com/br/");
      this.materials = new TextLinkPair("Materiais","http://tankionline.com/br/media/");
      this.forum = new TextLinkPair("Fórum","http://br.tankiforum.com/");
      this.wiki = new TextLinkPair("Wiki","http://br.tankiwiki.com/");
      this.ratings = new TextLinkPair("Classificações","http://ratings.tankionline.com/br/");
      this.help = new TextLinkPair("Ajuda","http://help.tankionline.com/pt-br/");
      this.license = new TextLinkPair("Contrato de licença","http://tankionline.com/br/eula/");
      this.aboutCompany = new TextLinkPair("©2017 Tanki Online Europe Ltd. Todos os direitos reservados.","");
      this.techSupport = new TextLinkPair("Contate-nos para tratar de quaisquer dificuldades:","");
      this.email = new TextLinkPair("support@tankionline.com","mailto:support@tankionline.com");
      this.rules = new TextLinkPair("Regras do jogo","http://tankionline.com/br/rules/");
      this.confidentialityPolicy = new TextLinkPair("Política de privacidade e cookies","http://tankionline.com/br/privacy/");
    }
  }
}
