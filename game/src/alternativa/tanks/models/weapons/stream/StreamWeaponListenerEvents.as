package alternativa.tanks.models.weapons.stream {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;

  public class StreamWeaponListenerEvents implements StreamWeaponListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function StreamWeaponListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onStart() : void {
      var i:int = 0;
      var m:StreamWeaponListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = StreamWeaponListener(this.impl[i]);
          m.onStart();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onStop() : void {
      var i:int = 0;
      var m:StreamWeaponListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = StreamWeaponListener(this.impl[i]);
          m.onStop();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onTargetsUpdated(param1:Vector3, param2:Vector.<TargetHit>) : void {
      var i:int = 0;
      var m:StreamWeaponListener = null;
      var direction:Vector3 = param1;
      var targets:Vector.<TargetHit> = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = StreamWeaponListener(this.impl[i]);
          m.onTargetsUpdated(direction,targets);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
