package alternativa.tanks.models.battle.battlefield.event {
  import flash.events.Event;

  public class BattleRenameEvent extends Event {
    public static const RENAME:String = "BattleRenameEvent.RENAME";

    private var _name:String;

    public function BattleRenameEvent(param1:String) {
      super(RENAME);
      this._name = param1;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
