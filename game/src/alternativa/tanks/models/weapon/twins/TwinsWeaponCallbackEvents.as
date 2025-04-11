package alternativa.tanks.models.weapon.twins {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TwinsWeaponCallbackEvents implements TwinsWeaponCallback {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TwinsWeaponCallbackEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShot(param1:int, param2:int, param3:int, param4:Vector3) : void {
      var i:int = 0;
      var m:TwinsWeaponCallback = null;
      var time:int = param1;
      var shotId:int = param2;
      var currentBarrel:int = param3;
      var shotDirection:Vector3 = param4;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TwinsWeaponCallback(this.impl[i]);
          m.onShot(time,shotId,currentBarrel,shotDirection);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onDummyShot(param1:int, param2:int) : void {
      var i:int = 0;
      var m:TwinsWeaponCallback = null;
      var time:int = param1;
      var currentBarrel:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TwinsWeaponCallback(this.impl[i]);
          m.onDummyShot(time,currentBarrel);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onTargetHit(param1:int, param2:Body, param3:Vector3) : void {
      var i:int = 0;
      var m:TwinsWeaponCallback = null;
      var shotId:int = param1;
      var targetBody:Body = param2;
      var hitPoint:Vector3 = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TwinsWeaponCallback(this.impl[i]);
          m.onTargetHit(shotId,targetBody,hitPoint);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onStaticHit(param1:int, param2:Vector3) : void {
      var i:int = 0;
      var m:TwinsWeaponCallback = null;
      var shotId:int = param1;
      var position:Vector3 = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TwinsWeaponCallback(this.impl[i]);
          m.onStaticHit(shotId,position);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
