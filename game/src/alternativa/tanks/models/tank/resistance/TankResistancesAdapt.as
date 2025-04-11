package alternativa.tanks.models.tank.resistance {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.resistance.TankResistance;

  public class TankResistancesAdapt implements TankResistances {
    private var object:IGameObject;
    private var impl:TankResistances;

    public function TankResistancesAdapt(param1:IGameObject, param2:TankResistances) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getResistance(param1:Boolean) : int {
      var result:int = 0;
      var update:Boolean = param1;
      try {
        Model.object = this.object;
        result = int(this.impl.getResistance(update));
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getResistances() : Vector.<TankResistance> {
      var result:Vector.<TankResistance> = null;
      try {
        Model.object = this.object;
        result = this.impl.getResistances();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function updateOthersResistances() : void {
      try {
        Model.object = this.object;
        this.impl.updateOthersResistances();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
