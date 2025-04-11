package alternativa.tanks.models.weapon.rocketlauncher.radio {
  import flash.events.Event;

  public class RocketExplodeEvent extends Event {
    public static var ALL:* = "ROCKET_EXPLODE_ALL_EVENT";
    public static var SINGLE:* = "ROCKET_EXPLODE_SINGLE_EVENT";

    public var rocketId:int = 0;

    public function RocketExplodeEvent(param1:String, param2:int = 0) {
      super(param1);
      this.rocketId = param2;
    }
  }
}
