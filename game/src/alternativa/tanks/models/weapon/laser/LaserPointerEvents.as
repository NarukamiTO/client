package alternativa.tanks.models.weapon.laser {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class LaserPointerEvents implements LaserPointer {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function LaserPointerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function updateDirection(param1:Vector3) : void {
      var i:int = 0;
      var m:LaserPointer = null;
      var direction:Vector3 = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = LaserPointer(this.impl[i]);
          m.updateDirection(direction);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function aimAtTank(param1:Tank, param2:Vector3) : void {
      var i:int = 0;
      var m:LaserPointer = null;
      var target:Tank = param1;
      var localPoint:Vector3 = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = LaserPointer(this.impl[i]);
          m.aimAtTank(target,localPoint);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function hideLaser() : void {
      var i:int = 0;
      var m:LaserPointer = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = LaserPointer(this.impl[i]);
          m.hideLaser();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getLaserPointerBlueColor() : uint {
      var result:uint = 0;
      var i:int = 0;
      var m:LaserPointer = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = LaserPointer(this.impl[i]);
          result = uint(m.getLaserPointerBlueColor());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getLaserPointerRedColor() : uint {
      var result:uint = 0;
      var i:int = 0;
      var m:LaserPointer = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = LaserPointer(this.impl[i]);
          result = uint(m.getLaserPointerRedColor());
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
