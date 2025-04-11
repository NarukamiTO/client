package alternativa.tanks.models.weapon.healing {
  import alternativa.physics.collision.types.RayHit;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class HealingGunCallbackEvents implements HealingGunCallback {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function HealingGunCallbackEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function updateHit(param1:int, param2:RayHit) : void {
      var i:int = 0;
      var m:HealingGunCallback = null;
      var time:int = param1;
      var rayHit:RayHit = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HealingGunCallback(this.impl[i]);
          m.updateHit(time,rayHit);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function stop(param1:int) : void {
      var i:int = 0;
      var m:HealingGunCallback = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HealingGunCallback(this.impl[i]);
          m.stop(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onTick(param1:int, param2:RayHit) : void {
      var i:int = 0;
      var m:HealingGunCallback = null;
      var time:int = param1;
      var rayHit:RayHit = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HealingGunCallback(this.impl[i]);
          m.onTick(time,rayHit);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
