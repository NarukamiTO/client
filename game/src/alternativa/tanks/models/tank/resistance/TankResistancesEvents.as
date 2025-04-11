package alternativa.tanks.models.tank.resistance {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.resistance.TankResistance;

  public class TankResistancesEvents implements TankResistances {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TankResistancesEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getResistance(param1:Boolean) : int {
      var result:int = 0;
      var i:int = 0;
      var m:TankResistances = null;
      var update:Boolean = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankResistances(this.impl[i]);
          result = int(m.getResistance(update));
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getResistances() : Vector.<TankResistance> {
      var result:Vector.<TankResistance> = null;
      var i:int = 0;
      var m:TankResistances = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankResistances(this.impl[i]);
          result = m.getResistances();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function updateOthersResistances() : void {
      var i:int = 0;
      var m:TankResistances = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankResistances(this.impl[i]);
          m.updateOthersResistances();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
