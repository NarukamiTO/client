package alternativa.tanks.models.weapons.discrete {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;

  public class DiscreteWeaponListenerEvents implements DiscreteWeaponListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function DiscreteWeaponListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShot(param1:IGameObject, param2:Vector3, param3:Vector.<TargetHit>) : void {
      var i:int = 0;
      var m:DiscreteWeaponListener = null;
      var shooter:IGameObject = param1;
      var direction:Vector3 = param2;
      var targets:Vector.<TargetHit> = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = DiscreteWeaponListener(this.impl[i]);
          m.onShot(shooter,direction,targets);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
