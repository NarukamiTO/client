package alternativa.tanks.models.tank.ultimate.hunter.stun {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UltimateStunListenerEvents implements UltimateStunListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function UltimateStunListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      var i:int = 0;
      var m:UltimateStunListener = null;
      var tank:Tank = param1;
      var local:Boolean = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UltimateStunListener(this.impl[i]);
          m.onStun(tank,local);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      var i:int = 0;
      var m:UltimateStunListener = null;
      var tank:Tank = param1;
      var local:Boolean = param2;
      var stunDurationMs:int = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UltimateStunListener(this.impl[i]);
          m.onCalm(tank,local,stunDurationMs);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
