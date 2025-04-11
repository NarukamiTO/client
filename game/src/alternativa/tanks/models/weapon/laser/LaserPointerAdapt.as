package alternativa.tanks.models.weapon.laser {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class LaserPointerAdapt implements LaserPointer {
    private var object:IGameObject;
    private var impl:LaserPointer;

    public function LaserPointerAdapt(param1:IGameObject, param2:LaserPointer) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function updateDirection(param1:Vector3) : void {
      var direction:Vector3 = param1;
      try {
        Model.object = this.object;
        this.impl.updateDirection(direction);
      }
      finally {
        Model.popObject();
      }
    }

    public function aimAtTank(param1:Tank, param2:Vector3) : void {
      var target:Tank = param1;
      var localPoint:Vector3 = param2;
      try {
        Model.object = this.object;
        this.impl.aimAtTank(target,localPoint);
      }
      finally {
        Model.popObject();
      }
    }

    public function hideLaser() : void {
      try {
        Model.object = this.object;
        this.impl.hideLaser();
      }
      finally {
        Model.popObject();
      }
    }

    public function getLaserPointerBlueColor() : uint {
      var result:uint = 0;
      try {
        Model.object = this.object;
        result = uint(this.impl.getLaserPointerBlueColor());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getLaserPointerRedColor() : uint {
      var result:uint = 0;
      try {
        Model.object = this.object;
        result = uint(this.impl.getLaserPointerRedColor());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
