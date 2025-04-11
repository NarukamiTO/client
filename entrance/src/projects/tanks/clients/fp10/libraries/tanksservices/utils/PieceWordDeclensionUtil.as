package projects.tanks.clients.fp10.libraries.tanksservices.utils {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class PieceWordDeclensionUtil {
    [Inject]
    public static var localeService:ILocaleService;

    private static const NOMINATIVE_ONE_DECLENSION:String = "NominativeOneDeclension";
    private static const NOMINATIVE_MANY_DECLENSION:String = "NominativeManyDeclension";
    private static const GENITIVE_MANY_DECLENSION:String = "GenitiveManyDeclension";

    public function PieceWordDeclensionUtil() {
      super();
    }

    public static function getLocalizedDeclension(param1:int) : String {
      var local2:String = param1 + " ";
      if(localeService.language == "ru") {
        switch(determineRussianWordFormType(param1)) {
          case NOMINATIVE_ONE_DECLENSION:
            local2 += localeService.getText(TanksLocale.TEXT_PIECE_1);
            break;
          case NOMINATIVE_MANY_DECLENSION:
            local2 += localeService.getText(TanksLocale.TEXT_PIECE_2);
            break;
          case GENITIVE_MANY_DECLENSION:
            local2 += localeService.getText(TanksLocale.TEXT_PIECE_3);
        }
      } else {
        local2 += param1 == 1 ? localeService.getText(TanksLocale.TEXT_PIECE_1) : localeService.getText(TanksLocale.TEXT_PIECE_2);
      }
      return local2;
    }

    private static function determineRussianWordFormType(param1:int) : String {
      var local3:int = 0;
      var local2:String = NOMINATIVE_ONE_DECLENSION;
      if(param1 % 100 >= 10 && param1 % 100 <= 20) {
        local2 = GENITIVE_MANY_DECLENSION;
      } else {
        local3 = param1 % 10;
        if(local3 == 1) {
          local2 = NOMINATIVE_ONE_DECLENSION;
        } else if(local3 >= 2 && local3 <= 4) {
          local2 = NOMINATIVE_MANY_DECLENSION;
        } else {
          local2 = GENITIVE_MANY_DECLENSION;
        }
      }
      return local2;
    }
  }
}
