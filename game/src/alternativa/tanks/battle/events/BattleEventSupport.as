package alternativa.tanks.battle.events {
  import flash.utils.Dictionary;

  public class BattleEventSupport implements BattleEventListener {
    private var dispatcher:BattleEventDispatcher;
    private var handlers:Dictionary = new Dictionary();

    public function BattleEventSupport(param1:BattleEventDispatcher) {
      super();
      this.dispatcher = param1;
    }

    public function addEventHandler(param1:Class, param2:Function) : void {
      this.handlers[param1] = param2;
    }

    public function activateHandlers() : void {
      var local1:* = undefined;
      for(local1 in this.handlers) {
        this.dispatcher.addBattleEventListener(local1,this);
      }
    }

    public function deactivateHandlers() : void {
      var local1:* = undefined;
      for(local1 in this.handlers) {
        this.dispatcher.removeBattleEventListener(local1,this);
      }
    }

    public function handleBattleEvent(param1:Object) : void {
      var local2:Function = this.handlers[param1.constructor];
      if(local2 != null) {
        local2(param1);
      }
    }

    public function dispatchEvent(param1:Object) : void {
      this.dispatcher.dispatchEvent(param1);
    }
  }
}
