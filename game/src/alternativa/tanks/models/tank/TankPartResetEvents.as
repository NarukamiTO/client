package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TankPartResetEvents implements TankPartReset {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TankPartResetEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function resetTankPart(param1:Tank) : void {
      var i:int = 0;
      var m:TankPartReset = null;
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankPartReset(this.impl[i]);
          m.resetTankPart(tank);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
