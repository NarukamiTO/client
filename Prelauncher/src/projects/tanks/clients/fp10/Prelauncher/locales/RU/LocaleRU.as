package projects.tanks.clients.fp10.Prelauncher.locales.RU {
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.PartnerLogo.PartnerLogo;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.locales.TextLinkPair;

  public class LocaleRU extends Locale {
    public function LocaleRU() {
      super();
      this.name = Locales.RU;
      this.playText = "ИГРАТЬ";
      this.exitText = "ВЫХОД";
      partners.push(PartnerLogo.VK,"http://vk.com/tankionline");
      partners.push(PartnerLogo.TWITTER,"http://twitter.com/tankionline");
      partners.push(PartnerLogo.YOUTUBE,"http://www.youtube.com/user/tankionline");
      partners.push(PartnerLogo.INSTAGRAM,"http://instagram.com/tankionline_ru");
      partners.push(PartnerLogo.OK,"https://ok.ru/tankionline");
      this.game = new TextLinkPair("Игра","http://tankionline.com/ru/");
      this.materials = new TextLinkPair("Материалы","http://tankionline.com/ru/media/");
      this.tournaments = new TextLinkPair("Турниры","http://tournament.tankionline.com/ru/");
      this.forum = new TextLinkPair("Форум","http://ru.tankiforum.com/");
      this.wiki = new TextLinkPair("Вики","http://ru.tankiwiki.com/");
      this.ratings = new TextLinkPair("Рейтинги","http://ratings.tankionline.com/ru/");
      this.help = new TextLinkPair("Помощь","http://help.tankionline.com/ru/");
      this.license = new TextLinkPair("Лицензионное соглашение","http://tankionline.com/ru/eula/");
      this.aboutCompany = new TextLinkPair("© ООО «Танки Онлайн» 2010–2017. Все права защищены.","");
      this.techSupport = new TextLinkPair("По всем вопросам следует писать на","");
      this.email = new TextLinkPair("help@tankionline.com","mailto:help@tankionline.com");
      this.rules = new TextLinkPair("Правила игры","http://tankionline.com/ru/rules/");
      this.confidentialityPolicy = new TextLinkPair("Политика конфиденциальности","http://tankionline.com/ru/privacy/");
    }
  }
}
