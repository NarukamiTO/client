package alternativa.tanks.models.tank.ultimate.hunter.stun {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UltimateStunListenerAdapt implements UltimateStunListener {
    private var object:IGameObject;
    private var impl:UltimateStunListener;

    public function UltimateStunListenerAdapt(param1:IGameObject, param2:UltimateStunListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      var tank:Tank = param1;
      var local:Boolean = param2;
      try {
        Model.object = this.object;
        this.impl.onStun(tank,local);
      }
      finally {
        Model.popObject();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      var tank:Tank = param1;
      var local:Boolean = param2;
      var stunDurationMs:int = param3;
      try {
        Model.object = this.object;
        this.impl.onCalm(tank,local,stunDurationMs);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
