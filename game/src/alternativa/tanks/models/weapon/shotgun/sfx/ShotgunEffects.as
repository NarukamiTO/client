package alternativa.tanks.models.weapon.shotgun.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.shotgun.ShotgunObject;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sfx.ISoundEffectDestructionListener;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.MuzzlePositionProvider;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import flash.media.Sound;
  import platform.client.fp10.core.type.AutoClosable;

  public class ShotgunEffects implements AutoClosable, ISoundEffectDestructionListener {
    [Inject]
    public static var battleService:BattleService;

    private static const SHOT_VOLUME:Number = 1;
    private static const RELOAD_SOUND_SHIFT:int = 500;
    private static const MAGAZINE_RELOAD_SOUND_SHIFT:int = 1000;

    private var shotgunSFX:ShotgunSFXData;
    private var reloadSoundEffect:MobileSound3DEffect;
    private var buffed:Boolean = false;

    public function ShotgunEffects(param1:ShotgunSFXData) {
      super();
      this.shotgunSFX = param1;
    }

    public function createShotEffects(param1:ShotgunObject, param2:AllGlobalGunParams, param3:WeaponPlatform, param4:Vector3) : void {
      this.createGraphicEffect(param1,param2,param3,param4);
      this.createSoundEffect(param2);
      this.createShotLightEffects(param3);
    }

    private function createSoundEffect(param1:AllGlobalGunParams) : void {
      var local2:Sound3D = Sound3D.create(this.shotgunSFX.shotSound,SHOT_VOLUME);
      battleService.addSound3DEffect(Sound3DEffect.create(param1.muzzlePosition,local2));
    }

    private function createGraphicEffect(param1:ShotgunObject, param2:AllGlobalGunParams, param3:WeaponPlatform, param4:Vector3) : void {
      var local5:ShotgunShotEffect = ShotgunShotEffect(battleService.getObjectPool().getObject(ShotgunShotEffect));
      local5.init(param1,param2,param3,param4,this.shotgunSFX,this.buffed);
      battleService.addGraphicEffect(local5);
    }

    public function createReloadSoundEffect(param1:Object3D, param2:int) : void {
      var local3:Sound = this.shotgunSFX.reloadSound;
      this.addReloadSound(local3,param2,RELOAD_SOUND_SHIFT,param1);
    }

    public function createMagazineReloadSoundEffect(param1:Object3D, param2:int) : void {
      var local3:Sound = this.shotgunSFX.magazineReloadSound;
      this.addReloadSound(local3,param2,MAGAZINE_RELOAD_SOUND_SHIFT,param1);
    }

    public function stopEffects() : void {
      if(this.reloadSoundEffect != null) {
        this.reloadSoundEffect.kill();
      }
    }

    private function addReloadSound(param1:Sound, param2:int, param3:int, param4:Object3D) : void {
      var local5:Sound3D = Sound3D.create(param1,SHOT_VOLUME);
      var local6:ObjectPool = battleService.getObjectPool();
      this.reloadSoundEffect = MobileSound3DEffect(local6.getObject(MobileSound3DEffect));
      var local7:int = param2 - param1.length + param3;
      var local8:int = 0;
      if(local7 < 0) {
        local8 = -local7;
        local7 = 0;
      }
      this.reloadSoundEffect.init(local5,param4,local7,1,local8,this);
      battleService.addSound3DEffect(this.reloadSoundEffect);
    }

    private function createShotLightEffects(param1:WeaponPlatform) : void {
      var local2:TankSkin = param1.getSkin();
      var local3:Object3D = local2.getTurret3D();
      var local4:Vector3 = param1.getLocalMuzzlePosition();
      var local5:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local6:MuzzlePositionProvider = MuzzlePositionProvider(battleService.getObjectPool().getObject(MuzzlePositionProvider));
      local6.init(local3,local4);
      local5.init(local6,this.shotgunSFX.shotLightAnimation);
      battleService.addGraphicEffect(local5);
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.shotgunSFX = null;
      if(this.reloadSoundEffect != null) {
        this.reloadSoundEffect.kill();
      }
    }

    public function onSoundEffectDestroyed(param1:ISound3DEffect) : void {
      if(this.reloadSoundEffect == param1) {
        this.reloadSoundEffect = null;
      }
    }

    public function setBuffed(param1:Boolean) : void {
      this.buffed = param1;
    }
  }
}
