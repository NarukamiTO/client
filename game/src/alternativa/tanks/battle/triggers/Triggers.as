package alternativa.tanks.battle.triggers {
  import alternativa.physics.Body;
  import alternativa.tanks.battle.*;

  public class Triggers {
    private const _triggers:Vector.<Trigger> = new Vector.<Trigger>();
    private const deferredActions:Vector.<DeferredAction> = new Vector.<DeferredAction>();

    private var running:Boolean;

    public function Triggers() {
      super();
    }

    public function add(param1:Trigger) : void {
      if(this.running) {
        this.deferredActions.push(new DeferredTriggerAddition(this,param1));
      } else if(this._triggers.indexOf(param1) < 0) {
        this._triggers.push(param1);
      }
    }

    public function remove(param1:Trigger) : void {
      var local2:int = 0;
      var local3:int = 0;
      if(this.running) {
        this.deferredActions.push(new DeferredTriggerDeletion(this,param1));
      } else {
        local2 = int(this._triggers.length);
        if(local2 > 0) {
          local3 = int(this._triggers.indexOf(param1));
          if(local3 >= 0) {
            this._triggers[local3] = this._triggers[--local2];
            this._triggers.length = local2;
          }
        }
      }
    }

    public function check(param1:Body) : void {
      var local2:int = 0;
      var local3:int = 0;
      var local4:Trigger = null;
      if(param1 != null) {
        this.running = true;
        local2 = int(this._triggers.length);
        local3 = 0;
        while(local3 < local2) {
          local4 = this._triggers[local3];
          local4.checkTrigger(param1);
          local3++;
        }
        this.running = false;
        this.executeDeferredActions();
      }
    }

    private function executeDeferredActions() : void {
      var local1:DeferredAction = null;
      while(true) {
        local1 = this.deferredActions.pop();
        if(local1 == null) {
          break;
        }
        local1.execute();
      }
    }
  }
}
