package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class PassToFirstBattle extends Event {
    public const PASS:String = "PassToFirstBattle.PASS";

    public function PassToFirstBattle() {
      super(this.PASS);
    }
  }
}
