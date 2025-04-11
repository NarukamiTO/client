package alternativa.tanks.models.weapon.flamethrower {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponGraphicEffect;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponSFXData;
  import alternativa.tanks.sfx.CollisionObject3DPositionProvider;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sfx.ISoundEffectDestructionListener;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.MuzzlePositionProvider;
  import alternativa.tanks.sfx.OmniStreamLightEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.StreamWeaponParticlesPositionProvider;
  import alternativa.tanks.utils.objectpool.ObjectPool;

  public class FlamethrowerEffects extends BattleRunnerProvider implements StreamWeaponEffects, ISoundEffectDestructionListener {
    [Inject]
    public static var battleService:BattleService;

    private static const NUMBER_OF_LOOPS:int = 99999;

    private const MUZZLE_SHIFT:Number = 100;

    private var objectPool:ObjectPool;
    private var range:Number;
    private var coneAngle:Number;
    private var sfxData:StreamWeaponSFXData;
    private var graphicEffect:StreamWeaponGraphicEffect;
    private var soundEffect:MobileSound3DEffect;
    private var muzzleLightEffect:OmniStreamLightEffect;
    private var lightEffect:OmniStreamLightEffect;
    private var buffedMode:Boolean;

    public function FlamethrowerEffects(param1:ObjectPool, param2:Number, param3:Number, param4:StreamWeaponSFXData) {
      super();
      this.objectPool = param1;
      this.range = param2;
      this.coneAngle = param3;
      this.sfxData = param4;
      this.buffedMode = false;
    }

    public function startEffects(param1:Body, param2:Vector3, param3:Object3D) : void {
      var local4:Sound3D = null;
      var local5:MuzzlePositionProvider = null;
      var local6:Vector3 = null;
      var local7:MuzzlePositionProvider = null;
      var local8:CollisionObject3DPositionProvider = null;
      var local9:StreamWeaponParticlesPositionProvider = null;
      if(this.graphicEffect == null) {
        this.graphicEffect = StreamWeaponGraphicEffect(this.objectPool.getObject(StreamWeaponGraphicEffect));
        this.graphicEffect.init(param1,this.range,this.coneAngle,FlamethrowerEffectsParams.PARTICLE_SPEED_PER_DISTANCE_METER,param2,param3,this.sfxData,getBattleRunner().getCollisionDetector(),FlamethrowerEffectsParams.PLANE_WIDTH,FlamethrowerEffectsParams.PLANE_LENGTH,FlamethrowerEffectsParams.PARTICLE_START_SIZE,FlamethrowerEffectsParams.PARTICLE_END_SIZE,FlamethrowerEffectsParams.FLAME_MUZZLE_OFFSET,FlamethrowerEffectsParams.FLAME_MUZZLE_RANDOM_OFFSET,this.buffedMode);
        battleService.getBattleScene3D().addGraphicEffect(this.graphicEffect);
        local4 = Sound3D.create(this.sfxData.shootingSound,FlamethrowerEffectsParams.SOUND_VOLUME);
        this.soundEffect = MobileSound3DEffect(this.objectPool.getObject(MobileSound3DEffect));
        this.soundEffect.init(local4,param3,0,NUMBER_OF_LOOPS,0,this);
        getBattleRunner().getSoundManager().addEffect(this.soundEffect);
        this.muzzleLightEffect = OmniStreamLightEffect(this.objectPool.getObject(OmniStreamLightEffect));
        local5 = MuzzlePositionProvider(this.objectPool.getObject(MuzzlePositionProvider));
        local6 = new Vector3();
        local6.copy(param2);
        local6.z += this.MUZZLE_SHIFT;
        local5.init(param3,param2);
        local5.init(param3,param2,0);
        local7 = MuzzlePositionProvider(this.objectPool.getObject(MuzzlePositionProvider));
        local7.init(param3,local6);
        local7.init(param3,local6,0);
        this.muzzleLightEffect.init(local7,this.sfxData.startLightAnimation,this.sfxData.loopLightAnimation);
        battleService.getBattleScene3D().addGraphicEffect(this.muzzleLightEffect);
        this.lightEffect = OmniStreamLightEffect(this.objectPool.getObject(OmniStreamLightEffect));
        local8 = CollisionObject3DPositionProvider(this.objectPool.getObject(CollisionObject3DPositionProvider));
        local8.init(param3,param2,getBattleRunner().getCollisionDetector(),FlamethrowerEffectsParams.FIRE_LIGHT_OFFSET);
        local9 = StreamWeaponParticlesPositionProvider(this.objectPool.getObject(StreamWeaponParticlesPositionProvider));
        local9.init(this.graphicEffect,local8);
        this.lightEffect.init(local9,this.sfxData.startFireAnimation,this.sfxData.loopFireAnimation);
        battleService.getBattleScene3D().addGraphicEffect(this.lightEffect);
      }
    }

    public function stopEffects() : void {
      if(this.graphicEffect != null) {
        this.graphicEffect.kill();
        this.graphicEffect = null;
        this.killSound();
        this.muzzleLightEffect.stop();
        this.muzzleLightEffect = null;
        this.lightEffect.stop();
        this.lightEffect = null;
      }
    }

    private function killSound() : void {
      if(this.soundEffect != null) {
        this.soundEffect.kill();
        this.soundEffect = null;
      }
    }

    public function onSoundEffectDestroyed(param1:ISound3DEffect) : void {
      if(this.soundEffect == param1) {
        this.soundEffect = null;
      }
    }

    public function updateRange(param1:Number) : void {
      this.range = param1;
      if(this.graphicEffect != null) {
        this.graphicEffect.updateRange(param1);
      }
    }

    public function setBuffedMode(param1:Boolean) : void {
      this.buffedMode = param1;
      if(this.graphicEffect != null) {
        this.graphicEffect.setBuffedMode(param1);
      }
    }
  }
}
