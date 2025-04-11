package alternativa.tanks.models.weapon.rotation {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponRotationLimitEvents implements WeaponRotationLimit {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function WeaponRotationLimitEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMaxAngle() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:WeaponRotationLimit = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponRotationLimit(this.impl[i]);
          result = Number(m.getMaxAngle());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMinAngle() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:WeaponRotationLimit = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponRotationLimit(this.impl[i]);
          result = Number(m.getMinAngle());
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
