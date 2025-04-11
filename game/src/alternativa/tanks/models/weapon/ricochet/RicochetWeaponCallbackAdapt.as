package alternativa.tanks.models.weapon.ricochet {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RicochetWeaponCallbackAdapt implements RicochetWeaponCallback {
    private var object:IGameObject;
    private var impl:RicochetWeaponCallback;

    public function RicochetWeaponCallbackAdapt(param1:IGameObject, param2:RicochetWeaponCallback) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShot(param1:int, param2:int, param3:Vector3) : void {
      var time:int = param1;
      var shotId:int = param2;
      var shotDirection:Vector3 = param3;
      try {
        Model.object = this.object;
        this.impl.onShot(time,shotId,shotDirection);
      }
      finally {
        Model.popObject();
      }
    }

    public function onDummyShot(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.onDummyShot(time);
      }
      finally {
        Model.popObject();
      }
    }

    public function onTargetHit(param1:int, param2:Body, param3:Vector.<Vector3>) : void {
      var shotId:int = param1;
      var targetBody:Body = param2;
      var impactPoints:Vector.<Vector3> = param3;
      try {
        Model.object = this.object;
        this.impl.onTargetHit(shotId,targetBody,impactPoints);
      }
      finally {
        Model.popObject();
      }
    }

    public function onStaticHit(param1:int, param2:Vector.<Vector3>) : void {
      var shotId:int = param1;
      var impactPoints:Vector.<Vector3> = param2;
      try {
        Model.object = this.object;
        this.impl.onStaticHit(shotId,impactPoints);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
