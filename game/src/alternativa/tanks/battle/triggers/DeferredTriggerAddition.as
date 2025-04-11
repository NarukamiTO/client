package alternativa.tanks.battle.triggers {
  import alternativa.tanks.battle.DeferredAction;
  import alternativa.tanks.battle.Trigger;

  public class DeferredTriggerAddition implements DeferredAction {
    private var triggers:Triggers;
    private var trigger:Trigger;

    public function DeferredTriggerAddition(param1:Triggers, param2:Trigger) {
      super();
      this.triggers = param1;
      this.trigger = param2;
    }

    public function execute() : void {
      this.triggers.add(this.trigger);
    }
  }
}
