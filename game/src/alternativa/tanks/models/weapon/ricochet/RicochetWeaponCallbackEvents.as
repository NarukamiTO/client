package alternativa.tanks.models.weapon.ricochet {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RicochetWeaponCallbackEvents implements RicochetWeaponCallback {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function RicochetWeaponCallbackEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShot(param1:int, param2:int, param3:Vector3) : void {
      var i:int = 0;
      var m:RicochetWeaponCallback = null;
      var time:int = param1;
      var shotId:int = param2;
      var shotDirection:Vector3 = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RicochetWeaponCallback(this.impl[i]);
          m.onShot(time,shotId,shotDirection);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onDummyShot(param1:int) : void {
      var i:int = 0;
      var m:RicochetWeaponCallback = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RicochetWeaponCallback(this.impl[i]);
          m.onDummyShot(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onTargetHit(param1:int, param2:Body, param3:Vector.<Vector3>) : void {
      var i:int = 0;
      var m:RicochetWeaponCallback = null;
      var shotId:int = param1;
      var targetBody:Body = param2;
      var impactPoints:Vector.<Vector3> = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RicochetWeaponCallback(this.impl[i]);
          m.onTargetHit(shotId,targetBody,impactPoints);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onStaticHit(param1:int, param2:Vector.<Vector3>) : void {
      var i:int = 0;
      var m:RicochetWeaponCallback = null;
      var shotId:int = param1;
      var impactPoints:Vector.<Vector3> = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RicochetWeaponCallback(this.impl[i]);
          m.onStaticHit(shotId,impactPoints);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
