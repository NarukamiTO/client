package alternativa.tanks.models.weapon.machinegun {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.machinegun.sfx.IMachineGunSFXModel;
  import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXData;
  import alternativa.tanks.models.weapons.stream.StreamWeaponCommunication;
  import alternativa.tanks.models.weapons.stream.StreamWeaponListener;
  import alternativa.tanks.models.weapons.targeting.CommonTargetingSystem;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.IMachineGunModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.MachineGunModelBase;

  [ModelInfo]
  public class MachineGunModel extends MachineGunModelBase implements IMachineGunModelBase, StreamWeaponListener, IWeaponModel, WeaponBuffListener, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    private static const MAX_DISTANCE:Number = 1000000;

    public function MachineGunModel() {
      super();
    }

    public function onStart() : void {
      this.remoteWeapon().start();
    }

    public function onStop() : void {
      this.remoteWeapon().stop();
    }

    public function onTargetsUpdated(param1:Vector3, param2:Vector.<TargetHit>) : void {
      this.remoteWeapon().updateTargets(param1,param2);
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var local2:WeaponObject = new WeaponObject(object);
      var local3:WeaponCommonData = local2.commonData();
      var local4:TargetingSystem = new CommonTargetingSystem(param1,local2,MAX_DISTANCE);
      var local5:MachineGunWeapon = new MachineGunWeapon(local4,param1,getInitParam(),this.getSfxData(),local3,StreamWeaponCommunication(object.adapt(StreamWeaponCommunication)),object);
      putData(MachineGunWeapon,local5);
      return local5;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:WeaponObject = new WeaponObject(object);
      var local3:WeaponCommonData = local2.commonData();
      var local4:MachineGunRemoteWeapon = new MachineGunRemoteWeapon(param1,getInitParam(),this.getSfxData(),local3);
      putData(MachineGunRemoteWeapon,local4);
      return local4;
    }

    private function getSfxData() : MachineGunSFXData {
      return IMachineGunSFXModel(object.adapt(IMachineGunSFXModel)).getSfxData();
    }

    private function remoteWeapon() : MachineGunRemoteWeapon {
      return MachineGunRemoteWeapon(getData(MachineGunRemoteWeapon));
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local5:MachineGunWeapon = null;
      var local4:MachineGunRemoteWeapon = this.remoteWeapon();
      if(local4 != null) {
        local4.updateRecoilForce(param3);
      } else {
        local5 = MachineGunWeapon(getData(MachineGunWeapon));
        if(local5 != null) {
          local5.updateRecoilForce(param3);
          local5.fullyRecharge();
          local5.setBuffed(param2);
        }
      }
    }

    public function reconfigureWeapon(param1:int, param2:int) : void {
      var local4:MachineGunWeapon = null;
      var local3:MachineGunRemoteWeapon = this.remoteWeapon();
      if(local3 != null) {
        local3.updateSpinTimes(param1,param2);
      } else {
        local4 = MachineGunWeapon(getData(MachineGunWeapon));
        if(local4 != null) {
          local4.updateSpinTimes(param1,param2);
        }
      }
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      var local3:Weapon = this.getWeapon();
      local3.disable(true);
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      var local4:Weapon = this.getWeapon();
      local4.enable();
    }

    private function getWeapon() : Weapon {
      var local1:MachineGunRemoteWeapon = this.remoteWeapon();
      if(local1 != null) {
        return local1;
      }
      return Weapon(getData(MachineGunWeapon));
    }

    public function setSpunState() : void {
      var local2:MachineGunWeapon = null;
      var local1:MachineGunRemoteWeapon = this.remoteWeapon();
      if(local1 != null) {
        local1.spin();
      } else {
        local2 = MachineGunWeapon(getData(MachineGunWeapon));
        if(local2 != null) {
          local2.spin();
        }
      }
    }
  }
}
