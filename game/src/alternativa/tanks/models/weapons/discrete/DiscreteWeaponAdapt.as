package alternativa.tanks.models.weapons.discrete {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DiscreteWeaponAdapt implements DiscreteWeapon {
    private var object:IGameObject;
    private var impl:DiscreteWeapon;

    public function DiscreteWeaponAdapt(param1:IGameObject, param2:DiscreteWeapon) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function tryToShoot(param1:int, param2:Vector3, param3:Vector.<Tank>) : void {
      var clientTime:int = param1;
      var direction:Vector3 = param2;
      var targets:Vector.<Tank> = param3;
      try {
        Model.object = this.object;
        this.impl.tryToShoot(clientTime,direction,targets);
      }
      finally {
        Model.popObject();
      }
    }

    public function tryToDummyShoot(param1:int, param2:Vector3) : void {
      var clientTime:int = param1;
      var direction:Vector3 = param2;
      try {
        Model.object = this.object;
        this.impl.tryToDummyShoot(clientTime,direction);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
