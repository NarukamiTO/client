package alternativa.tanks.models.weapon.rotation {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponRotationLimitAdapt implements WeaponRotationLimit {
    private var object:IGameObject;
    private var impl:WeaponRotationLimit;

    public function WeaponRotationLimitAdapt(param1:IGameObject, param2:WeaponRotationLimit) {
      super();
      this.object = param1;
      this.impl = param2;
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

    public function getMinAngle() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getMinAngle());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
