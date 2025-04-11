package alternativa.tanks.models.battle.commonflag {
  public class FlagBaseTriggerHandler implements IFlagBaseTrigerEvents {
    private var callback:Function;

    public function FlagBaseTriggerHandler(param1:Function) {
      super();
      this.callback = param1;
    }

    public function onEnterFlagBaseZone() : void {
      this.callback.apply();
    }

    public function onLeaveFlagBaseZone() : void {
    }
  }
}
