package alternativa.tanks.battle.events {
  import flash.utils.Dictionary;

  public class BattleEventDispatcherImpl implements BattleEventDispatcher {
    private var numberProcessingEvents:int;
    private var eventListeners:Dictionary = new Dictionary();
    private var newListeners:Dictionary = new Dictionary();
    private var removedListeners:Dictionary = new Dictionary();
    private var dispatchedOnce:Dictionary = new Dictionary();

    public function BattleEventDispatcherImpl() {
      super();
    }

    private static function addListener(param1:Dictionary, param2:Class, param3:BattleEventListener) : void {
      var local4:Vector.<BattleEventListener> = param1[param2];
      if(local4 == null) {
        local4 = new Vector.<BattleEventListener>();
        param1[param2] = local4;
      }
      if(local4.indexOf(param3) < 0) {
        local4.push(param3);
      }
    }

    private static function removeListener(param1:Dictionary, param2:Class, param3:BattleEventListener) : void {
      var local5:int = 0;
      var local4:Vector.<BattleEventListener> = param1[param2];
      if(local4 != null) {
        local5 = int(local4.indexOf(param3));
        if(local5 >= 0) {
          if(local4.length == 1) {
            delete param1[param2];
          } else {
            local4.splice(local5,1);
          }
        }
      }
    }

    public function addBattleEventListener(param1:Class, param2:BattleEventListener) : void {
      if(this.numberProcessingEvents > 0) {
        removeListener(this.removedListeners,param1,param2);
        addListener(this.newListeners,param1,param2);
      } else {
        addListener(this.eventListeners,param1,param2);
      }
    }

    public function removeBattleEventListener(param1:Class, param2:BattleEventListener) : void {
      if(this.numberProcessingEvents > 0) {
        removeListener(this.newListeners,param1,param2);
        addListener(this.removedListeners,param1,param2);
      } else {
        removeListener(this.eventListeners,param1,param2);
      }
    }

    public function dispatchEvent(param1:Object) : void {
      var local4:int = 0;
      var local5:int = 0;
      ++this.numberProcessingEvents;
      var local2:Vector.<BattleEventListener> = this.eventListeners[param1.constructor];
      if(local2 != null) {
        local4 = int(local2.length);
        local5 = 0;
        while(local5 < local4) {
          BattleEventListener(local2[local5]).handleBattleEvent(param1);
          local5++;
        }
      }
      --this.numberProcessingEvents;
      var local3:IBattleEvent = param1 as IBattleEvent;
      if(local3 != null) {
        local3.recycle();
      }
      this.processDeferredActions();
    }

    public function dispatchEventOnce(param1:Object) : void {
      if(!this.dispatchedOnce[param1.constructor]) {
        this.dispatchedOnce[param1.constructor] = true;
        this.dispatchEvent(param1);
      }
    }

    public function clearDispatchedOnce() : void {
      this.dispatchedOnce = new Dictionary();
    }

    private function processDeferredActions() : void {
      var local1:* = undefined;
      var local2:int = 0;
      var local3:int = 0;
      var local4:Class = null;
      var local5:Vector.<BattleEventListener> = null;
      if(this.numberProcessingEvents > 0) {
        return;
      }
      for(local1 in this.removedListeners) {
        local4 = local1;
        local5 = this.removedListeners[local1];
        delete this.removedListeners[local1];
        local3 = int(local5.length);
        local2 = 0;
        while(local2 < local3) {
          removeListener(this.eventListeners,local4,local5[local2]);
          local2++;
        }
      }
      for(local1 in this.newListeners) {
        local4 = local1;
        local5 = this.newListeners[local1];
        delete this.newListeners[local1];
        local3 = int(local5.length);
        local2 = 0;
        while(local2 < local3) {
          addListener(this.eventListeners,local4,local5[local2]);
          local2++;
        }
      }
    }
  }
}
