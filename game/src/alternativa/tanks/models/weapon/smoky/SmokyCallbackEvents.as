package alternativa.tanks.models.weapon.smoky {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class SmokyCallbackEvents implements SmokyCallback {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function SmokyCallbackEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShot(param1:int) : void {
      var i:int = 0;
      var m:SmokyCallback = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SmokyCallback(this.impl[i]);
          m.onShot(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onShotStatic(param1:int, param2:Vector3) : void {
      var i:int = 0;
      var m:SmokyCallback = null;
      var time:int = param1;
      var hitPoint:Vector3 = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SmokyCallback(this.impl[i]);
          m.onShotStatic(time,hitPoint);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onShotTarget(param1:int, param2:Vector3, param3:Body) : void {
      var i:int = 0;
      var m:SmokyCallback = null;
      var time:int = param1;
      var hitPoint:Vector3 = param2;
      var target:Body = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SmokyCallback(this.impl[i]);
          m.onShotTarget(time,hitPoint,target);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
