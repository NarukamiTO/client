package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class InitTankPartEvents implements InitTankPart {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function InitTankPartEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initTankPart(param1:Tank) : void {
      var i:int = 0;
      var m:InitTankPart = null;
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = InitTankPart(this.impl[i]);
          m.initTankPart(tank);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
