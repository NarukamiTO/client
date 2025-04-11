package alternativa.tanks.models.weapon.railgun {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RailgunCallbackEvents implements RailgunCallback {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function RailgunCallbackEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onStartCharging(param1:int) : void {
      var i:int = 0;
      var m:RailgunCallback = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RailgunCallback(this.impl[i]);
          m.onStartCharging(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>) : void {
      var i:int = 0;
      var m:RailgunCallback = null;
      var time:int = param1;
      var staticHitPoint:Vector3 = param2;
      var targets:Vector.<Body> = param3;
      var targetHitPoints:Vector.<Vector3> = param4;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RailgunCallback(this.impl[i]);
          m.onShot(time,staticHitPoint,targets,targetHitPoints);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onShotDummy(param1:int) : void {
      var i:int = 0;
      var m:RailgunCallback = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RailgunCallback(this.impl[i]);
          m.onShotDummy(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
