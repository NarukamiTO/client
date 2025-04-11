package alternativa.tanks.models.weapon.artillery.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryTurretSkin;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.artillery.ArtilleryCannonEffect;
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
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  public class ArtilleryEffects implements ISoundEffectDestructionListener, AutoClosable {
    [Inject]
    public static var localTankService:LocalTankInfoService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    private static const SHOT_SOUND_BY_POWER:Vector.<Number> = Vector.<Number>([0.3,0.6,0.9,1]);

    public static const FAR_SHOT_SOUND_DISTANCE:Number = 10000;
    public static const POWER_FOR_FAR_SHOT:Number = 0.5;

    private var sfxData:ArtillerySfxData;
    private var reloadSoundEffect:MobileSound3DEffect;
    private var chargingSound:MobileSound3DEffect;
    private var cannonEffect:ArtilleryCannonEffect;
    private var shotEffect:ArtilleryShotEffect;
    private var isLocal:Boolean;

    public function ArtilleryEffects(param1:ArtillerySfxData, param2:ArtilleryTurretSkin, param3:Boolean) {
      super();
      this.sfxData = param1;
      this.isLocal = param3;
      this.shotEffect = new ArtilleryShotEffect(param1);
      this.cannonEffect = new ArtilleryCannonEffect(param2);
    }

    private function createShotLightEffect(param1:Vector3, param2:Object3D) : void {
      var local3:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local4:MuzzlePositionProvider = MuzzlePositionProvider(battleService.getObjectPool().getObject(MuzzlePositionProvider));
      local4.init(param2,param1);
      local3.init(local4,this.sfxData.shotLightAnimation);
      battleService.addGraphicEffect(local3);
    }

    private function createShotSoundEffect(param1:Vector3, param2:Number, param3:Vector3, param4:Number) : void {
      var local6:int = 0;
      var local5:Number = Vector3.distanceBetween(param1,param3);
      if(local5 < FAR_SHOT_SOUND_DISTANCE) {
        local6 = this.getShotSoundIndex(param2);
        battleService.addSound3DEffect(Sound3DEffect.create(param1,Sound3D.create(this.sfxData.shotSounds[local6],0.8)));
      } else if(param2 >= POWER_FOR_FAR_SHOT && param4 >= 15) {
        battleService.addSound3DEffect(Sound3DEffect.create(param3,Sound3D.create(this.sfxData.farShotSound,0.8)));
      }
    }

    private function getShotSoundIndex(param1:Number) : int {
      var local2:int = 0;
      while(local2 < SHOT_SOUND_BY_POWER.length) {
        if(param1 < SHOT_SOUND_BY_POWER[local2]) {
          return local2;
        }
        local2++;
      }
      return SHOT_SOUND_BY_POWER.length - 1;
    }

    public function createReloadSoundEffect(param1:Object3D, param2:Number) : void {
      var local3:Sound = this.sfxData.reloadSound;
      var local4:Sound3D = Sound3D.create(local3,0.8);
      var local5:ObjectPool = battleService.getObjectPool();
      this.reloadSoundEffect = MobileSound3DEffect(local5.getObject(MobileSound3DEffect));
      var local6:int = param2 - local3.length + 1300;
      if(local6 >= 0) {
        this.reloadSoundEffect.init(local4,param1,local6,1,0,this);
      } else {
        this.reloadSoundEffect.init(local4,param1,0,1,-local6,this);
      }
      battleService.addSound3DEffect(this.reloadSoundEffect);
    }

    public function createChargingSoundEffect(param1:Object3D) : void {
      var local2:Sound = this.sfxData.chargingSound;
      var local3:Sound3D = Sound3D.create(local2,0.8);
      var local4:ObjectPool = battleService.getObjectPool();
      this.chargingSound = MobileSound3DEffect(local4.getObject(MobileSound3DEffect));
      this.chargingSound.init(local3,param1,0,1,0,null);
      battleService.addSound3DEffect(this.chargingSound);
    }

    public function createShotEffect(param1:WeaponPlatform, param2:AllGlobalGunParams, param3:Number, param4:Number, param5:int) : void {
      this.killChargingSound();
      this.cannonEffect.run();
      this.shotEffect.run(param2);
      this.createShotLightEffect(param1.getLocalMuzzlePosition(),param1.getTurret3D());
      if(localTankService.isLocalTankLoaded()) {
        this.createShotSoundEffect(param1.getBody().state.position,param3,localTankService.getLocalTank().getBody().state.position,param4);
        if(this.isLocal) {
          this.createReloadSoundEffect(param1.getTurret3D(),param5);
        }
      } else if(battleInfoService.isSpectatorMode()) {
        this.createShotSoundEffect(param1.getBody().state.position,param3,battleService.getBattleScene3D().getCamera().position,param4);
      }
    }

    public function killChargingSound() : void {
      if(this.chargingSound != null) {
        this.chargingSound.kill();
        this.chargingSound = null;
      }
    }

    public function onSoundEffectDestroyed(param1:ISound3DEffect) : void {
      if(this.reloadSoundEffect == param1) {
        this.reloadSoundEffect = null;
      }
    }

    public function reset() : void {
      this.killChargingSound();
    }

    public function close() : void {
      this.killChargingSound();
    }

    public function stopReloadSound() : void {
      if(this.reloadSoundEffect != null) {
        this.reloadSoundEffect.kill();
      }
    }
  }
}
