package alternativa.tanks.models.weapon.rocketlauncher {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RemoteRocketLauncherWeapon;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeapon;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeaponProvider;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListener;
  import alternativa.tanks.models.weapons.shell.ShellWeaponListener;
  import alternativa.tanks.models.weapons.shell.TargetShellWeaponListener;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.IRocketLauncherModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherModelBase;

  [ModelInfo]
  public class RocketLauncherModel extends RocketLauncherModelBase implements IRocketLauncherModelBase, ShellWeaponListener, TargetShellWeaponListener, ObjectLoadListener, IWeaponModel, WeaponBuffListener, RocketLauncherWeaponProvider, WeaponReloadTimeChangedListener, UltimateStunListener {
    public function RocketLauncherModel() {
      super();
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var local2:RocketLauncherObject = new RocketLauncherObject(object);
      var local3:RocketLauncherWeapon = new RocketLauncherWeapon(param1,local2,getInitParam());
      putData(RocketLauncherWeapon,local3);
      return local3;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:RocketLauncherObject = new RocketLauncherObject(object);
      local2.markAsRemote();
      var local3:RemoteRocketLauncherWeapon = new RemoteRocketLauncherWeapon(local2,getInitParam());
      putData(RemoteRocketLauncherWeapon,local3);
      return local3;
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:RocketLauncherCC = getInitParam();
      local1.minSpeed = BattleUtils.toClientScale(local1.minSpeed);
      local1.maxSpeed = BattleUtils.toClientScale(local1.maxSpeed);
      local1.shellRadius = BattleUtils.toClientScale(local1.shellRadius);
      local1.shotRange = BattleUtils.toClientScale(local1.shotRange);
    }

    public function onShot(param1:int, param2:int, param3:Vector3) : void {
      this.remoteWeapon().simpleShoot(param1,param3,param2);
    }

    public function onDummyShot(param1:int) : void {
      this.remoteWeapon().dummyShoot(param1);
    }

    public function onShotWithTarget(param1:int, param2:int, param3:Vector3, param4:Tank, param5:Vector3) : void {
      this.remoteWeapon().salvoShoot(param1,param3,param2,param4,param5);
    }

    public function remoteWeapon() : RemoteRocketLauncherWeapon {
      return RemoteRocketLauncherWeapon(getData(RemoteRocketLauncherWeapon));
    }

    public function localWeapon() : RocketLauncherWeapon {
      return RocketLauncherWeapon(getData(RocketLauncherWeapon));
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      var local3:RocketLauncherWeapon = null;
      if(this.isLocalWeapon()) {
        local3 = this.localWeapon();
        if(local3 != null) {
          local3.weaponReloadTimeChanged(param1,param2);
        }
      }
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local4:RocketLauncherWeapon = this.localWeapon();
      if(local4 != null) {
        local4.setBuffState(param2);
        local4.updateRecoilForce(param3);
        if(!param2) {
          local4.fullyRecharge();
        }
      } else {
        this.remoteWeapon().updateRecoilForce(param3);
      }
    }

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return ITankModel(local1.user.adapt(ITankModel)).isLocal();
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        this.localWeapon().stun();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        this.localWeapon().calm(param3);
      }
    }
  }
}
