package alternativa.tanks.models.tank.speedcharacteristics {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class SpeedCharacteristicsAdapt implements SpeedCharacteristics {
    private var object:IGameObject;
    private var impl:SpeedCharacteristics;

    public function SpeedCharacteristicsAdapt(param1:IGameObject, param2:SpeedCharacteristics) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setInitialTankState() : void {
      try {
        Model.object = this.object;
        this.impl.setInitialTankState();
      }
      finally {
        Model.popObject();
      }
    }

    public function getMaxHullTurnSpeed() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getMaxHullTurnSpeed());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxTurretTurnSpeed() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getMaxTurretTurnSpeed());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTurretRotationCoefficient() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getTurretRotationCoefficient());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
