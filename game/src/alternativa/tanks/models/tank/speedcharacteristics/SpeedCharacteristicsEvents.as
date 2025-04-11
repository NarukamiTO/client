package alternativa.tanks.models.tank.speedcharacteristics {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class SpeedCharacteristicsEvents implements SpeedCharacteristics {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function SpeedCharacteristicsEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setInitialTankState() : void {
      var i:int = 0;
      var m:SpeedCharacteristics = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpeedCharacteristics(this.impl[i]);
          m.setInitialTankState();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getMaxHullTurnSpeed() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:SpeedCharacteristics = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpeedCharacteristics(this.impl[i]);
          result = Number(m.getMaxHullTurnSpeed());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxTurretTurnSpeed() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:SpeedCharacteristics = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpeedCharacteristics(this.impl[i]);
          result = Number(m.getMaxTurretTurnSpeed());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTurretRotationCoefficient() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:SpeedCharacteristics = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpeedCharacteristics(this.impl[i]);
          result = Number(m.getTurretRotationCoefficient());
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
