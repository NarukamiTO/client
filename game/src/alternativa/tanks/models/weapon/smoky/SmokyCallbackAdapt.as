package alternativa.tanks.models.weapon.smoky {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class SmokyCallbackAdapt implements SmokyCallback {
    private var object:IGameObject;
    private var impl:SmokyCallback;

    public function SmokyCallbackAdapt(param1:IGameObject, param2:SmokyCallback) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShot(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.onShot(time);
      }
      finally {
        Model.popObject();
      }
    }

    public function onShotStatic(param1:int, param2:Vector3) : void {
      var time:int = param1;
      var hitPoint:Vector3 = param2;
      try {
        Model.object = this.object;
        this.impl.onShotStatic(time,hitPoint);
      }
      finally {
        Model.popObject();
      }
    }

    public function onShotTarget(param1:int, param2:Vector3, param3:Body) : void {
      var time:int = param1;
      var hitPoint:Vector3 = param2;
      var target:Body = param3;
      try {
        Model.object = this.object;
        this.impl.onShotTarget(time,hitPoint,target);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
