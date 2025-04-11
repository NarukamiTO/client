package alternativa.tanks.models.battle.gui.drone {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;

  public class IDroneModelAdapt implements IDroneModel {
    private var object:IGameObject;
    private var impl:IDroneModel;

    public function IDroneModelAdapt(param1:IGameObject, param2:IDroneModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initDrones(param1:Tank, param2:Boolean, param3:TankLogicState) : void {
      var tank:Tank = param1;
      var isLocal:Boolean = param2;
      var logicState:TankLogicState = param3;
      try {
        Model.object = this.object;
        this.impl.initDrones(tank,isLocal,logicState);
      }
      finally {
        Model.popObject();
      }
    }

    public function canOverheal() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.canOverheal());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
