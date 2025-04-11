package alternativa.tanks.models.clan.info {
  import flash.events.EventDispatcher;

  public class ClanInfoDelayed extends EventDispatcher {
    private static var _instance:ClanInfoDelayed;

    public static const EVENT_PREFIX:String = "ClanInfoDelayed.";

    public function ClanInfoDelayed() {
      super();
      if(_instance != null) {
        throw new Error("More than one instance created!");
      }
    }

    public static function getInstance() : ClanInfoDelayed {
      if(_instance == null) {
        _instance = new ClanInfoDelayed();
      }
      return _instance;
    }
  }
}
