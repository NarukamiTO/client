package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TankPartResetAdapt implements TankPartReset {
    private var object:IGameObject;
    private var impl:TankPartReset;

    public function TankPartResetAdapt(param1:IGameObject, param2:TankPartReset) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function resetTankPart(param1:Tank) : void {
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        this.impl.resetTankPart(tank);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
