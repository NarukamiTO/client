package alternativa.tanks.models.weapons.discrete {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DiscreteWeaponEvents implements DiscreteWeapon {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function DiscreteWeaponEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function tryToShoot(param1:int, param2:Vector3, param3:Vector.<Tank>) : void {
      var i:int = 0;
      var m:DiscreteWeapon = null;
      var clientTime:int = param1;
      var direction:Vector3 = param2;
      var targets:Vector.<Tank> = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = DiscreteWeapon(this.impl[i]);
          m.tryToShoot(clientTime,direction,targets);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function tryToDummyShoot(param1:int, param2:Vector3) : void {
      var i:int = 0;
      var m:DiscreteWeapon = null;
      var clientTime:int = param1;
      var direction:Vector3 = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = DiscreteWeapon(this.impl[i]);
          m.tryToDummyShoot(clientTime,direction);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
