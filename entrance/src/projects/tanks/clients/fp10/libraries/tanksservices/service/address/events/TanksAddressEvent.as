package projects.tanks.clients.fp10.libraries.tanksservices.service.address.events {
  import flash.events.Event;

  public class TanksAddressEvent extends Event {
    public static const SERVER_CHANGED:String = "TanksAddressEvent.SERVER_CHANGED";
    public static const TRY_CHANGE_SERVER:String = "TanksAddressEvent.TRY_CHANGE_SERVER";
    public static const BATTLE_CHANGED:String = "TanksAddressEvent.BATTLE_CHANGED";
    public static const BATTLE_RESET:String = "TanksAddressEvent.BATTLE_RESET";
    public static const BACK:String = "TanksAddressEvent.BACK";

    public function TanksAddressEvent(param1:String) {
      super(param1);
    }
  }
}
