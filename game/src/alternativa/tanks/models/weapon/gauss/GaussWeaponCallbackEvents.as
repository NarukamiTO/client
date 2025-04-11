package alternativa.tanks.models.weapon.gauss {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GaussWeaponCallbackEvents implements GaussWeaponCallback {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function GaussWeaponCallbackEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function doPrimaryShot(param1:int, param2:Vector3) : void {
      var i:int = 0;
      var m:GaussWeaponCallback = null;
      var shotId:int = param1;
      var shotDirection:Vector3 = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GaussWeaponCallback(this.impl[i]);
          m.doPrimaryShot(shotId,shotDirection);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function doSecondaryShot(param1:IGameObject, param2:Vector3, param3:Vector3) : void {
      var i:int = 0;
      var m:GaussWeaponCallback = null;
      var target:IGameObject = param1;
      var targetPosition:Vector3 = param2;
      var localHitPosition:Vector3 = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GaussWeaponCallback(this.impl[i]);
          m.doSecondaryShot(target,targetPosition,localHitPosition);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function doDummyShot() : void {
      var i:int = 0;
      var m:GaussWeaponCallback = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GaussWeaponCallback(this.impl[i]);
          m.doDummyShot();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function doStartAiming() : void {
      var i:int = 0;
      var m:GaussWeaponCallback = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GaussWeaponCallback(this.impl[i]);
          m.doStartAiming();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function doStopAiming() : void {
      var i:int = 0;
      var m:GaussWeaponCallback = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GaussWeaponCallback(this.impl[i]);
          m.doStopAiming();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function doPrimaryHitStatic(param1:int, param2:Vector3) : void {
      var i:int = 0;
      var m:GaussWeaponCallback = null;
      var shotId:int = param1;
      var targetPosition:Vector3 = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GaussWeaponCallback(this.impl[i]);
          m.doPrimaryHitStatic(shotId,targetPosition);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function doPrimaryHitTarget(param1:int, param2:IGameObject, param3:Vector3, param4:Vector3) : void {
      var i:int = 0;
      var m:GaussWeaponCallback = null;
      var shotId:int = param1;
      var target:IGameObject = param2;
      var targetPosition:Vector3 = param3;
      var hitPointWorld:Vector3 = param4;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GaussWeaponCallback(this.impl[i]);
          m.doPrimaryHitTarget(shotId,target,targetPosition,hitPointWorld);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
