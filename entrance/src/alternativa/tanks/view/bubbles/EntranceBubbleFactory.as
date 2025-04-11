package alternativa.tanks.view.bubbles {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.geom.Point;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class EntranceBubbleFactory {
    [Inject]
    public static var LocaleService:ILocaleService;

    public function EntranceBubbleFactory() {
      super();
    }

    public static function passwordIsTooEasyBubble() : Bubble {
      return customBubble(TanksLocale.TEXT_HELP_PASSWORD_IS_TOO_SIMPLE,HelperAlign.TOP_LEFT);
    }

    public static function passwordsDoNotMatchBubble() : Bubble {
      return customBubble(TanksLocale.TEXT_HELP_PASSWORDS_DO_NOT_MATCH,HelperAlign.TOP_LEFT);
    }

    public static function nameIsIncorrectBubble() : Bubble {
      return customBubble(TanksLocale.TEXT_HELP_NAME_IS_FORBIDDEN,HelperAlign.TOP_LEFT);
    }

    public static function nameIsNotUniqueBubble() : Bubble {
      return customBubble(TanksLocale.TEXT_HELP_NAME_IS_NOT_UNIQUE,HelperAlign.TOP_LEFT);
    }

    public static function emailIsBusy() : Bubble {
      return customBubble(TanksLocale.TEXT_ERROR_EMAIL_NOT_UNIQUE,HelperAlign.TOP_LEFT);
    }

    public static function emailIsInvalidBubble() : Bubble {
      return customBubble(TanksLocale.TEXT_ERROR_EMAIL_INVALID,HelperAlign.TOP_LEFT);
    }

    public static function emailDomainIsForbidden() : Bubble {
      return customBubble(TanksLocale.TEXT_ERROR_EMAIL_DOMAIN_IS_FORBIDDEN,HelperAlign.TOP_LEFT);
    }

    public static function emailInvalidBubble() : Bubble {
      return customBubble(TanksLocale.TEXT_ERROR_EMAIL_INVALID,HelperAlign.TOP_LEFT);
    }

    public static function symbolIsNotAllowedBubble() : Bubble {
      return customBubble(TanksLocale.TEXT_HELP_SYMBOL_IS_NOT_ALLOWED,HelperAlign.TOP_LEFT);
    }

    public static function nameIsIncorrectinPartnerBubble() : Bubble {
      return partnerBubble(TanksLocale.TEXT_HELP_NAME_IS_FORBIDDEN,HelperAlign.BOTTOM_LEFT);
    }

    public static function nameIsNotUniqueinPartnerBubble() : Bubble {
      return partnerBubble(TanksLocale.TEXT_HELP_NAME_IS_NOT_UNIQUE,HelperAlign.BOTTOM_LEFT);
    }

    public static function symbolIsNotAllowedinPartnerBubble() : Bubble {
      return partnerWindowBubble(TanksLocale.TEXT_HELP_SYMBOL_IS_NOT_ALLOWED,HelperAlign.BOTTOM_LEFT);
    }

    public static function customBubble(param1:String, param2:int) : Bubble {
      var local3:Bubble = new Bubble(new Point(10,10));
      local3.text = LocaleService.getText(param1);
      local3.arrowLehgth = 20;
      local3.arrowAlign = param2;
      return local3;
    }

    private static function partnerBubble(param1:String, param2:int) : Bubble {
      var local3:Bubble = new Bubble(new Point(10,5));
      local3.text = LocaleService.getText(param1);
      local3.arrowLehgth = 20;
      local3.arrowAlign = param2;
      return local3;
    }

    private static function partnerWindowBubble(param1:String, param2:int) : Bubble {
      var local3:Bubble = new Bubble(new Point(360,65));
      local3.text = LocaleService.getText(param1);
      local3.arrowLehgth = 20;
      local3.arrowAlign = param2;
      return local3;
    }
  }
}
