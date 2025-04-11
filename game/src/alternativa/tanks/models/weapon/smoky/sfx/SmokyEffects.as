package alternativa.tanks.models.weapon.smoky.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.smoky.ISmokyEffects;
  import alternativa.tanks.models.weapon.smoky.SmokyEffectsParams;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.MuzzlePositionProvider;
  import alternativa.tanks.sfx.PlaneMuzzleFlashEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.sound.ISoundManager;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import flash.display.BlendMode;

  public class SmokyEffects implements ISmokyEffects {
    [Inject]
    public static var battleService:BattleService;

    private var soundManager:ISoundManager;
    private var objectPool:ObjectPool;
    private var sfxData:SmokySFXData;

    public function SmokyEffects(param1:ISoundManager, param2:ObjectPool, param3:SmokySFXData) {
      super();
      this.soundManager = param1;
      this.objectPool = param2;
      this.sfxData = param3;
    }

    public function createShotEffects(param1:Vector3, param2:Object3D) : void {
      this.createShotSoundEffect(param2);
      this.createMuzzleFlashEffect(param1,param2);
      this.createMuzzleFlashLightEffect(param1,param2);
    }

    private function createShotSoundEffect(param1:Object3D) : void {
      var local2:Sound3D = Sound3D.create(this.sfxData.shotSound,SmokyEffectsParams.SHOT_SOUND_VOLUME);
      this.soundManager.addEffect(Sound3DEffect.create(new Vector3(param1.x,param1.y,param1.z),local2));
    }

    private function createMuzzleFlashEffect(param1:Vector3, param2:Object3D) : void {
      var local3:PlaneMuzzleFlashEffect = PlaneMuzzleFlashEffect(this.objectPool.getObject(PlaneMuzzleFlashEffect));
      local3.init(param1,param2,this.sfxData.muzzleFlashMaterial,SmokyEffectsParams.SHOT_GRAPHIC_EFFECT_LIFE_TIME,SmokyEffectsParams.PLANE_WIDTH,SmokyEffectsParams.PLANE_LENGTH);
      battleService.getBattleScene3D().addGraphicEffect(local3);
    }

    private function createMuzzleFlashLightEffect(param1:Vector3, param2:Object3D) : void {
      var local3:AnimatedLightEffect = AnimatedLightEffect(this.objectPool.getObject(AnimatedLightEffect));
      var local4:MuzzlePositionProvider = MuzzlePositionProvider(this.objectPool.getObject(MuzzlePositionProvider));
      local4.init(param2,param1);
      local3.init(local4,this.sfxData.shotLightAnimation);
      battleService.getBattleScene3D().addGraphicEffect(local3);
    }

    public function createExplosionEffects(param1:Vector3) : void {
      this.createExplosionSoundEffect(param1);
      this.createExplosionGraphicEffect(param1);
      this.createExplosionLightEffect(param1);
    }

    private function createExplosionLightEffect(param1:Vector3) : void {
      var local2:AnimatedLightEffect = AnimatedLightEffect(this.objectPool.getObject(AnimatedLightEffect));
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.objectPool.getObject(StaticObject3DPositionProvider));
      local3.init(param1,SmokyEffectsParams.EXPLOSION_OFFSET_TO_CAMERA);
      local2.init(local3,this.sfxData.hitLightAnimation);
      battleService.getBattleScene3D().addGraphicEffect(local2);
    }

    private function createExplosionSoundEffect(param1:Vector3) : void {
      var local2:Sound3D = Sound3D.create(this.sfxData.explosionSound,1);
      this.soundManager.addEffect(Sound3DEffect.create(param1,local2,SmokyEffectsParams.EXPLOSION_SOUND_DELAY));
    }

    private function createExplosionGraphicEffect(param1:Vector3) : void {
      var local2:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.objectPool.getObject(StaticObject3DPositionProvider));
      local2.init(param1,SmokyEffectsParams.EXPLOSION_OFFSET_TO_CAMERA);
      var local3:AnimatedSpriteEffect = AnimatedSpriteEffect(this.objectPool.getObject(AnimatedSpriteEffect));
      local3.init(this.sfxData.explosionSize,this.sfxData.explosionSize,this.sfxData.explosionAnimation,0,local2);
      battleService.getBattleScene3D().addGraphicEffect(local3);
    }

    public function createExplosionMark(param1:Vector3, param2:Vector3) : void {
      battleService.getBattleScene3D().addDecal(param2,param1,SmokyEffectsParams.DECAL_RADIUS,this.sfxData.explosionMarkMaterial);
    }

    public function createCriticalHitEffects(param1:Vector3) : void {
      var local2:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.objectPool.getObject(StaticObject3DPositionProvider));
      local2.init(param1,SmokyEffectsParams.EXPLOSION_OFFSET_TO_CAMERA + 50);
      var local3:AnimatedSpriteEffect = AnimatedSpriteEffect(this.objectPool.getObject(AnimatedSpriteEffect));
      local3.initLooped(this.sfxData.criticalHitSize,this.sfxData.criticalHitSize,this.sfxData.criticalHitAnimation,0,local2,0.5,0.5,null,70,BlendMode.NORMAL,2);
      battleService.getBattleScene3D().addGraphicEffect(local3);
    }
  }
}
