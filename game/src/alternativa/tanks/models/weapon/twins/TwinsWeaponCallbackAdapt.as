package alternativa.tanks.models.weapon.twins {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TwinsWeaponCallbackAdapt implements TwinsWeaponCallback {
    private var object:IGameObject;
    private var impl:TwinsWeaponCallback;

    public function TwinsWeaponCallbackAdapt(param1:IGameObject, param2:TwinsWeaponCallback) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShot(param1:int, param2:int, param3:int, param4:Vector3) : void {
      var time:int = param1;
      var shotId:int = param2;
      var currentBarrel:int = param3;
      var shotDirection:Vector3 = param4;
      try {
        Model.object = this.object;
        this.impl.onShot(time,shotId,currentBarrel,shotDirection);
      }
      finally {
        Model.popObject();
      }
    }

    public function onDummyShot(param1:int, param2:int) : void {
      var time:int = param1;
      var currentBarrel:int = param2;
      try {
        Model.object = this.object;
        this.impl.onDummyShot(time,currentBarrel);
      }
      finally {
        Model.popObject();
      }
    }

    public function onTargetHit(param1:int, param2:Body, param3:Vector3) : void {
      var shotId:int = param1;
      var targetBody:Body = param2;
      var hitPoint:Vector3 = param3;
      try {
        Model.object = this.object;
        this.impl.onTargetHit(shotId,targetBody,hitPoint);
      }
      finally {
        Model.popObject();
      }
    }

    public function onStaticHit(param1:int, param2:Vector3) : void {
      var shotId:int = param1;
      var position:Vector3 = param2;
      try {
        Model.object = this.object;
        this.impl.onStaticHit(shotId,position);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
