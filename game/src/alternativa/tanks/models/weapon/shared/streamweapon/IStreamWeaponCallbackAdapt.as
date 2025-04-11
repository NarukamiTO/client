package alternativa.tanks.models.weapon.shared.streamweapon {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IStreamWeaponCallbackAdapt implements IStreamWeaponCallback {
    private var object:IGameObject;
    private var impl:IStreamWeaponCallback;

    public function IStreamWeaponCallbackAdapt(param1:IGameObject, param2:IStreamWeaponCallback) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function start(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.start(time);
      }
      finally {
        Model.popObject();
      }
    }

    public function stop(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.stop(time);
      }
      finally {
        Model.popObject();
      }
    }

    public function onTick(param1:Weapon, param2:Vector.<Body>, param3:Vector.<Number>, param4:Vector.<Vector3>, param5:int) : void {
      var weapon:Weapon = param1;
      var bodies:Vector.<Body> = param2;
      var distances:Vector.<Number> = param3;
      var hitPositions:Vector.<Vector3> = param4;
      var time:int = param5;
      try {
        Model.object = this.object;
        this.impl.onTick(weapon,bodies,distances,hitPositions,time);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
