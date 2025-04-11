package alternativa.tanks.models.battle.gui.drone {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;

  public class IDroneModelEvents implements IDroneModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IDroneModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initDrones(param1:Tank, param2:Boolean, param3:TankLogicState) : void {
      var i:int = 0;
      var m:IDroneModel = null;
      var tank:Tank = param1;
      var isLocal:Boolean = param2;
      var logicState:TankLogicState = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IDroneModel(this.impl[i]);
          m.initDrones(tank,isLocal,logicState);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function canOverheal() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IDroneModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IDroneModel(this.impl[i]);
          result = Boolean(m.canOverheal());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
