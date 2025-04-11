package alternativa.tanks.models.weapon.angles.verticals.autoaiming {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class VerticalAutoAimingAdapt implements VerticalAutoAiming {
    private var object:IGameObject;
    private var impl:VerticalAutoAiming;

    public function VerticalAutoAimingAdapt(param1:IGameObject, param2:VerticalAutoAiming) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getElevationAngleUp() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getElevationAngleUp());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getNumRaysUp() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getNumRaysUp());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getElevationAngleDown() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getElevationAngleDown());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getNumRaysDown() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getNumRaysDown());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxAngle() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getMaxAngle());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
