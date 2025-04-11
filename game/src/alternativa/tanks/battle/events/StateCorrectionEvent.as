package alternativa.tanks.battle.events {
  public class StateCorrectionEvent {
    public static const REGULAR_UPDATE:StateCorrectionEvent = new StateCorrectionEvent(false);
    public static const MANDATORY_UPDATE:StateCorrectionEvent = new StateCorrectionEvent(true);

    private var _mandatory:Boolean;

    public function StateCorrectionEvent(param1:Boolean) {
      super();
      this._mandatory = param1;
    }

    public function get mandatory() : Boolean {
      return this._mandatory;
    }
  }
}
