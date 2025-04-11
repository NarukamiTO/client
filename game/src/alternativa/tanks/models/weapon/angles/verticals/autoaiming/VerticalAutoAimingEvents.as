package alternativa.tanks.models.weapon.angles.verticals.autoaiming {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class VerticalAutoAimingEvents implements VerticalAutoAiming {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function VerticalAutoAimingEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getElevationAngleUp() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:VerticalAutoAiming = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = VerticalAutoAiming(this.impl[i]);
          result = Number(m.getElevationAngleUp());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getNumRaysUp() : int {
      var result:int = 0;
      var i:int = 0;
      var m:VerticalAutoAiming = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = VerticalAutoAiming(this.impl[i]);
          result = int(m.getNumRaysUp());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getElevationAngleDown() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:VerticalAutoAiming = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = VerticalAutoAiming(this.impl[i]);
          result = Number(m.getElevationAngleDown());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getNumRaysDown() : int {
      var result:int = 0;
      var i:int = 0;
      var m:VerticalAutoAiming = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = VerticalAutoAiming(this.impl[i]);
          result = int(m.getNumRaysDown());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxAngle() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:VerticalAutoAiming = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = VerticalAutoAiming(this.impl[i]);
          result = Number(m.getMaxAngle());
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
