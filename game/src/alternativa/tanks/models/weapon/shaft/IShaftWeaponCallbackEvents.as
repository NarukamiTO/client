package alternativa.tanks.models.weapon.shaft {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IShaftWeaponCallbackEvents implements IShaftWeaponCallback {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IShaftWeaponCallbackEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onBeginEnergyDrain(param1:int) : void {
      var i:int = 0;
      var m:IShaftWeaponCallback = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IShaftWeaponCallback(this.impl[i]);
          m.onBeginEnergyDrain(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onAimedShot(param1:int, param2:Vector3, param3:Body, param4:Vector3) : void {
      var i:int = 0;
      var m:IShaftWeaponCallback = null;
      var time:int = param1;
      var staticHitPoint:Vector3 = param2;
      var target:Body = param3;
      var targetHitPoint:Vector3 = param4;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IShaftWeaponCallback(this.impl[i]);
          m.onAimedShot(time,staticHitPoint,target,targetHitPoint);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onQuickShot(param1:int, param2:Vector3, param3:Body, param4:Vector3) : void {
      var i:int = 0;
      var m:IShaftWeaponCallback = null;
      var time:int = param1;
      var staticHitPoint:Vector3 = param2;
      var target:Body = param3;
      var targetHitPoint:Vector3 = param4;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IShaftWeaponCallback(this.impl[i]);
          m.onQuickShot(time,staticHitPoint,target,targetHitPoint);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onManualTargetingStart() : void {
      var i:int = 0;
      var m:IShaftWeaponCallback = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IShaftWeaponCallback(this.impl[i]);
          m.onManualTargetingStart();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onManualTargetingStop() : void {
      var i:int = 0;
      var m:IShaftWeaponCallback = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IShaftWeaponCallback(this.impl[i]);
          m.onManualTargetingStop();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function enteredInManualMode() : void {
      var i:int = 0;
      var m:IShaftWeaponCallback = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IShaftWeaponCallback(this.impl[i]);
          m.enteredInManualMode();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
