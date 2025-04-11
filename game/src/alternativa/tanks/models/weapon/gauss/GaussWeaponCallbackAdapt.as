package alternativa.tanks.models.weapon.gauss {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GaussWeaponCallbackAdapt implements GaussWeaponCallback {
    private var object:IGameObject;
    private var impl:GaussWeaponCallback;

    public function GaussWeaponCallbackAdapt(param1:IGameObject, param2:GaussWeaponCallback) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function doPrimaryShot(param1:int, param2:Vector3) : void {
      var shotId:int = param1;
      var shotDirection:Vector3 = param2;
      try {
        Model.object = this.object;
        this.impl.doPrimaryShot(shotId,shotDirection);
      }
      finally {
        Model.popObject();
      }
    }

    public function doSecondaryShot(param1:IGameObject, param2:Vector3, param3:Vector3) : void {
      var target:IGameObject = param1;
      var targetPosition:Vector3 = param2;
      var localHitPosition:Vector3 = param3;
      try {
        Model.object = this.object;
        this.impl.doSecondaryShot(target,targetPosition,localHitPosition);
      }
      finally {
        Model.popObject();
      }
    }

    public function doDummyShot() : void {
      try {
        Model.object = this.object;
        this.impl.doDummyShot();
      }
      finally {
        Model.popObject();
      }
    }

    public function doStartAiming() : void {
      try {
        Model.object = this.object;
        this.impl.doStartAiming();
      }
      finally {
        Model.popObject();
      }
    }

    public function doStopAiming() : void {
      try {
        Model.object = this.object;
        this.impl.doStopAiming();
      }
      finally {
        Model.popObject();
      }
    }

    public function doPrimaryHitStatic(param1:int, param2:Vector3) : void {
      var shotId:int = param1;
      var targetPosition:Vector3 = param2;
      try {
        Model.object = this.object;
        this.impl.doPrimaryHitStatic(shotId,targetPosition);
      }
      finally {
        Model.popObject();
      }
    }

    public function doPrimaryHitTarget(param1:int, param2:IGameObject, param3:Vector3, param4:Vector3) : void {
      var shotId:int = param1;
      var target:IGameObject = param2;
      var targetPosition:Vector3 = param3;
      var hitPointWorld:Vector3 = param4;
      try {
        Model.object = this.object;
        this.impl.doPrimaryHitTarget(shotId,target,targetPosition,hitPointWorld);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
