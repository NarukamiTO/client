package controls {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class Rank {
    private static var _ranks:Array;

    [Inject]
    public static var localeService:ILocaleService;

    public function Rank() {
      super();
    }

    public static function name(param1:int) : String {
      return ranks[param1 - 1];
    }

    public static function get ranks() : Array {
      var local1:String = null;
      if(_ranks == null) {
        local1 = localeService.getText(TanksLocale.TEXT_RANK_NAMES);
        _ranks = local1.split(",");
      }
      return _ranks;
    }
  }
}
