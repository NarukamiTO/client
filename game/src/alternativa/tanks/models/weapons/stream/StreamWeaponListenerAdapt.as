package alternativa.tanks.models.weapons.stream {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;

  public class StreamWeaponListenerAdapt implements StreamWeaponListener {
    private var object:IGameObject;
    private var impl:StreamWeaponListener;

    public function StreamWeaponListenerAdapt(param1:IGameObject, param2:StreamWeaponListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onStart() : void {
      try {
        Model.object = this.object;
        this.impl.onStart();
      }
      finally {
        Model.popObject();
      }
    }

    public function onStop() : void {
      try {
        Model.object = this.object;
        this.impl.onStop();
      }
      finally {
        Model.popObject();
      }
    }

    public function onTargetsUpdated(param1:Vector3, param2:Vector.<TargetHit>) : void {
      var direction:Vector3 = param1;
      var targets:Vector.<TargetHit> = param2;
      try {
        Model.object = this.object;
        this.impl.onTargetsUpdated(direction,targets);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
