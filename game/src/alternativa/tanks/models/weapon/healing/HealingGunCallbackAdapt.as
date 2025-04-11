package alternativa.tanks.models.weapon.healing {
  import alternativa.physics.collision.types.RayHit;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class HealingGunCallbackAdapt implements HealingGunCallback {
    private var object:IGameObject;
    private var impl:HealingGunCallback;

    public function HealingGunCallbackAdapt(param1:IGameObject, param2:HealingGunCallback) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function updateHit(param1:int, param2:RayHit) : void {
      var time:int = param1;
      var rayHit:RayHit = param2;
      try {
        Model.object = this.object;
        this.impl.updateHit(time,rayHit);
      }
      finally {
        Model.popObject();
      }
    }

    public function stop(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.stop(time);
      }
      finally {
        Model.popObject();
      }
    }

    public function onTick(param1:int, param2:RayHit) : void {
      var time:int = param1;
      var rayHit:RayHit = param2;
      try {
        Model.object = this.object;
        this.impl.onTick(time,rayHit);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
