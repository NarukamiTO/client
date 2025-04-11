package alternativa.tanks.models.weapon.shaft {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.shaft.sfx.ShaftTrailEffect;
  import alternativa.tanks.models.weapon.shaft.sfx.TrailEffect1;
  import alternativa.tanks.models.weapon.shaft.sfx.TrailEffect2;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.MuzzlePositionProvider;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import flash.media.SoundChannel;

  public class ShaftEffects {
    public static const MUZZLE_FLASH_SIZE:Number = 200;
    public static const EXPLOSION_WIDTH:Number = 200;

    private static const EXPLOSION_OFFSET_TO_CAMERA:Number = 110;
    private static const SHOT_SOUND_VOLUME:Number = 0.4;
    private static const EXPLOSION_SOUND_VOLUME:Number = 0.8;
    private static const ZOOM_MODE_SOUND_VOLUME:Number = 0.35;
    private static const CHARGING_SOUND_FADE_TIME_MS:int = 1000;
    private static const vectorToHitPoint:Vector3 = new Vector3();
    private static const TRAIL_DURATION:int = 300;

    private var sfxData:ShaftSFXData;
    private var battleService:BattleService;
    private var turretSoundChannel:SoundChannel;
    private var manualModeEffect:MobileSound3DEffect;

    public function ShaftEffects(param1:ShaftSFXData, param2:BattleService) {
      super();
      this.sfxData = param1;
      this.battleService = param2;
    }

    public function playTargetingSound(param1:Boolean) : void {
      if(param1) {
        if(this.turretSoundChannel == null) {
          this.turretSoundChannel = this.battleService.soundManager.playSound(this.sfxData.targetingSound,0,9999);
        }
      } else if(this.turretSoundChannel != null) {
        this.battleService.soundManager.stopSound(this.turretSoundChannel);
        this.turretSoundChannel = null;
      }
    }

    public function createManualModeEffects(param1:Object3D) : void {
      var local2:Sound3D = null;
      if(this.manualModeEffect == null) {
        this.manualModeEffect = MobileSound3DEffect(this.battleService.getObjectPool().getObject(MobileSound3DEffect));
        local2 = Sound3D.create(this.sfxData.zoomModeSound,ZOOM_MODE_SOUND_VOLUME);
        this.manualModeEffect.init(local2,param1,0,9999);
        this.battleService.addSound3DEffect(this.manualModeEffect);
      }
    }

    public function stopManualTargetingEffects() : void {
      if(this.manualModeEffect != null) {
        this.manualModeEffect.kill();
        this.manualModeEffect = null;
      }
    }

    public function fadeChargingEffect() : void {
      if(this.manualModeEffect != null) {
        this.manualModeEffect.fade(CHARGING_SOUND_FADE_TIME_MS);
      }
    }

    public function createShotSoundEffect(param1:Vector3) : void {
      var local2:Sound3D = Sound3D.create(this.sfxData.shotSound,SHOT_SOUND_VOLUME);
      var local3:Sound3DEffect = Sound3DEffect.create(param1,local2);
      this.battleService.addSound3DEffect(local3);
    }

    public function createMuzzleFlashEffect(param1:Vector3, param2:Object3D) : void {
      var local3:ObjectPool = this.battleService.getObjectPool();
      var local4:MuzzlePositionProvider = MuzzlePositionProvider(local3.getObject(MuzzlePositionProvider));
      local4.init(param2,param1,10);
      var local5:AnimatedSpriteEffect = AnimatedSpriteEffect(local3.getObject(AnimatedSpriteEffect));
      local5.init(MUZZLE_FLASH_SIZE,MUZZLE_FLASH_SIZE,this.sfxData.muzzleFlashAnimation,0,local4);
      this.battleService.addGraphicEffect(local5);
      this.createLightMuzzleFlashEffect(param1,param2);
    }

    public function createLightMuzzleFlashEffect(param1:Vector3, param2:Object3D) : void {
      var local3:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local4:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
      local4.init(param2,param1);
      local3.init(local4,this.sfxData.shotLightAnimation);
      this.battleService.addGraphicEffect(local3);
    }

    public function createHitPointsGraphicEffects(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3, param5:Vector3) : void {
      if(param1 != null) {
        this.createEffectsForPoint(param1,param3,param4,param5,false);
      }
      if(param2 != null) {
        this.createEffectsForPoint(param2,param3,param4,param5,true);
      }
    }

    private function createEffectsForPoint(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3, param5:Boolean) : void {
      var local7:Number = NaN;
      var local6:Number = this.sfxData.trailLength;
      vectorToHitPoint.diff(param1,param2);
      if(vectorToHitPoint.dot(param3) > 0) {
        local7 = vectorToHitPoint.length();
        if(local7 > local6) {
          local7 = local6;
        }
        this.createTrailEffect(TrailEffect1,param1,param4,local7,local7 / local6);
        if(param5) {
          this.createTrailEffect(TrailEffect2,param1,param4,local7,0.5);
        }
      }
      this.createExplosionGraphicEffect(param1);
      this.createExplosionSoundEffect(param1);
    }

    private function createExplosionGraphicEffect(param1:Vector3) : void {
      var local2:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local2.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      var local3:AnimatedSpriteEffect = AnimatedSpriteEffect(this.battleService.getObjectPool().getObject(AnimatedSpriteEffect));
      local3.init(EXPLOSION_WIDTH,2.5 * EXPLOSION_WIDTH,this.sfxData.explosionAnimation,0,local2);
      this.battleService.addGraphicEffect(local3);
      this.createExplosionLightEffect(param1);
    }

    private function createExplosionLightEffect(param1:Vector3) : void {
      var local2:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local3.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      local2.init(local3,this.sfxData.hitLightAnimation);
      this.battleService.addGraphicEffect(local2);
    }

    private function createExplosionSoundEffect(param1:Vector3) : void {
      var local2:Sound3D = Sound3D.create(this.sfxData.explosionSound,EXPLOSION_SOUND_VOLUME);
      var local3:Sound3DEffect = Sound3DEffect(this.battleService.getObjectPool().getObject(Sound3DEffect));
      local3.init(param1,local2,100);
      this.battleService.addSound3DEffect(local3);
    }

    private function createTrailEffect(param1:Class, param2:Vector3, param3:Vector3, param4:Number, param5:Number) : void {
      var local6:ShaftTrailEffect = ShaftTrailEffect(this.battleService.getObjectPool().getObject(param1));
      local6.init(param2,param3,param4,param5,this.sfxData.trailMaterial,TRAIL_DURATION);
      this.battleService.addGraphicEffect(local6);
    }

    public function destroy() : void {
      if(this.turretSoundChannel != null) {
        this.battleService.soundManager.stopSound(this.turretSoundChannel);
        this.turretSoundChannel = null;
      }
      this.stopManualTargetingEffects();
    }

    public function createHitMark(param1:Vector3, param2:Vector3) : void {
      if(param2 != null) {
        this.battleService.getBattleScene3D().addDecal(param2,param1,50,this.sfxData.hitMarkMaterial);
      }
    }
  }
}
