package alternativa.tanks.models.weapon.terminator {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.objects.tank.tankskin.terminator.TerminatorTurretSkin;
  import alternativa.tanks.models.weapon.rocketlauncher.RocketLauncherObject;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponObject;
  import platform.client.fp10.core.type.IGameObject;

  public class TerminatorObject extends DiscreteWeaponObject {
    private var _rocketLauncherObject:RocketLauncherObject;

    public function TerminatorObject(param1:IGameObject) {
      super(param1);
      this._rocketLauncherObject = new RocketLauncherObject(param1);
    }

    public function getSkin() : TerminatorTurretSkin {
      return TerminatorSkin(object.adapt(TerminatorSkin)).getSkin();
    }

    public function get rocketLauncherObject() : RocketLauncherObject {
      return this._rocketLauncherObject;
    }

    public function primaryShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>, param5:int) : * {
      Terminator(object.adapt(Terminator)).primaryShot(param1,param2,param3,param4,param5);
    }

    public function primaryDummyShot(param1:int, param2:int) : * {
      Terminator(object.adapt(Terminator)).primaryDummyShot(param1,param2);
    }

    public function primaryCharge(param1:int, param2:int) : * {
      Terminator(object.adapt(Terminator)).primaryCharge(param1,param2);
    }

    public function secondaryOpen(param1:int) : * {
      Terminator(object.adapt(Terminator)).secondaryOpen(param1);
    }

    public function secondaryHide(param1:int) : * {
      Terminator(object.adapt(Terminator)).secondaryHide(param1);
    }
  }
}
