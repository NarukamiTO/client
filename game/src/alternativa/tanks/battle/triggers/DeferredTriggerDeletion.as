package alternativa.tanks.battle.triggers {
  import alternativa.tanks.battle.DeferredAction;
  import alternativa.tanks.battle.Trigger;

  public class DeferredTriggerDeletion implements DeferredAction {
    private var triggers:Triggers;
    private var trigger:Trigger;

    public function DeferredTriggerDeletion(param1:Triggers, param2:Trigger) {
      super();
      this.triggers = param1;
      this.trigger = param2;
    }

    public function execute() : void {
      this.triggers.remove(this.trigger);
    }
  }
}
