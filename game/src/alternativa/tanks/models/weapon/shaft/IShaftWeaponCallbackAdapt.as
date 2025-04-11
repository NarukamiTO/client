package alternativa.tanks.models.weapon.shaft {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IShaftWeaponCallbackAdapt implements IShaftWeaponCallback {
    private var object:IGameObject;
    private var impl:IShaftWeaponCallback;

    public function IShaftWeaponCallbackAdapt(param1:IGameObject, param2:IShaftWeaponCallback) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onBeginEnergyDrain(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.onBeginEnergyDrain(time);
      }
      finally {
        Model.popObject();
      }
    }

    public function onAimedShot(param1:int, param2:Vector3, param3:Body, param4:Vector3) : void {
      var time:int = param1;
      var staticHitPoint:Vector3 = param2;
      var target:Body = param3;
      var targetHitPoint:Vector3 = param4;
      try {
        Model.object = this.object;
        this.impl.onAimedShot(time,staticHitPoint,target,targetHitPoint);
      }
      finally {
        Model.popObject();
      }
    }

    public function onQuickShot(param1:int, param2:Vector3, param3:Body, param4:Vector3) : void {
      var time:int = param1;
      var staticHitPoint:Vector3 = param2;
      var target:Body = param3;
      var targetHitPoint:Vector3 = param4;
      try {
        Model.object = this.object;
        this.impl.onQuickShot(time,staticHitPoint,target,targetHitPoint);
      }
      finally {
        Model.popObject();
      }
    }

    public function onManualTargetingStart() : void {
      try {
        Model.object = this.object;
        this.impl.onManualTargetingStart();
      }
      finally {
        Model.popObject();
      }
    }

    public function onManualTargetingStop() : void {
      try {
        Model.object = this.object;
        this.impl.onManualTargetingStop();
      }
      finally {
        Model.popObject();
      }
    }

    public function enteredInManualMode() : void {
      try {
        Model.object = this.object;
        this.impl.enteredInManualMode();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
