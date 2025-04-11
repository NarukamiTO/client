package alternativa.tanks.models.weapon.shared.streamweapon {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IStreamWeaponCallbackEvents implements IStreamWeaponCallback {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IStreamWeaponCallbackEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function start(param1:int) : void {
      var i:int = 0;
      var m:IStreamWeaponCallback = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStreamWeaponCallback(this.impl[i]);
          m.start(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function stop(param1:int) : void {
      var i:int = 0;
      var m:IStreamWeaponCallback = null;
      var time:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStreamWeaponCallback(this.impl[i]);
          m.stop(time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onTick(param1:Weapon, param2:Vector.<Body>, param3:Vector.<Number>, param4:Vector.<Vector3>, param5:int) : void {
      var i:int = 0;
      var m:IStreamWeaponCallback = null;
      var weapon:Weapon = param1;
      var bodies:Vector.<Body> = param2;
      var distances:Vector.<Number> = param3;
      var hitPositions:Vector.<Vector3> = param4;
      var time:int = param5;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStreamWeaponCallback(this.impl[i]);
          m.onTick(weapon,bodies,distances,hitPositions,time);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
