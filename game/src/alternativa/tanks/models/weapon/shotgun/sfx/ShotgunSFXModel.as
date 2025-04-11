package alternativa.tanks.models.weapon.shotgun.sfx {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponUtils;
  import alternativa.tanks.models.weapon.shotgun.ShotgunObject;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx.IShotgunSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx.ShotgunSFXModelBase;

  [ModelInfo]
  public class ShotgunSFXModel extends ShotgunSFXModelBase implements IShotgunSFXModelBase, ShotgunSFX, ObjectLoadPostListener, DiscreteWeaponListener {
    [Inject]
    public static var battleService:BattleService;

    private var gunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private var _shotgunObject:ShotgunObject;

    public function ShotgunSFXModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
      var local2:ShotgunSFXData = new ShotgunSFXData(getInitParam(),local1.createAnimation("shot"));
      putData(ShotgunSFXData,local2);
      var local3:ShotgunEffects = new ShotgunEffects(local2);
      putData(ShotgunEffects,local3);
    }

    public function onShot(param1:IGameObject, param2:Vector3, param3:Vector.<TargetHit>) : void {
      this.showShotEffects(param1,param2);
    }

    private function showShotEffects(param1:IGameObject, param2:Vector3) : void {
      var local4:Tank = null;
      var local3:ITankModel = ITankModel(param1.adapt(ITankModel));
      if(!local3.isLocal()) {
        this.calculateGunParams(param1);
        local4 = local3.getTank();
        this.getEffects().createShotEffects(this.weaponObject(),this.gunParams,local4,param2);
      }
    }

    private function calculateGunParams(param1:IGameObject) : void {
      var local2:ITankModel = ITankModel(param1.adapt(ITankModel));
      var local3:Tank = local2.getTank();
      WeaponUtils.calculateMainGunParams(local3.getTurret3D(),local3.getLocalMuzzlePosition(),this.gunParams);
    }

    public function getEffects() : ShotgunEffects {
      return ShotgunEffects(getData(ShotgunEffects));
    }

    private function weaponObject() : ShotgunObject {
      if(this._shotgunObject == null) {
        this._shotgunObject = new ShotgunObject(object);
      } else {
        this._shotgunObject.setObject(object);
      }
      return this._shotgunObject;
    }
  }
}
