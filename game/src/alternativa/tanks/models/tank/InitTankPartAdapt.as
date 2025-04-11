package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class InitTankPartAdapt implements InitTankPart {
    private var object:IGameObject;
    private var impl:InitTankPart;

    public function InitTankPartAdapt(param1:IGameObject, param2:InitTankPart) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initTankPart(param1:Tank) : void {
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        this.impl.initTankPart(tank);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
