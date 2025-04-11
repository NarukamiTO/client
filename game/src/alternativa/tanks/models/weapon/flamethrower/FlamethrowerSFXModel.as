package alternativa.tanks.models.weapon.flamethrower {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.colortransform.ColorTransformConsumer;
  import alternativa.tanks.models.sfx.colortransform.ColorTransformEntry;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponSFXData;
  import alternativa.tanks.utils.GraphicsUtils;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.FlameThrowingSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.FlameThrowingSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.IFlameThrowingSFXModelBase;

  [ModelInfo]
  public class FlamethrowerSFXModel extends FlameThrowingSFXModelBase implements IFlameThrowingSFXModelBase, ObjectLoadListener, ObjectUnloadListener, IFlamethrowerSFXModel, ColorTransformConsumer {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    public function FlamethrowerSFXModel() {
      super();
    }

    private static function getParticleAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      var local2:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local2.material.resolution = FlamethrowerEffectsParams.PARTICLE_END_SIZE / param1.frameWidth;
      return local2;
    }

    private static function getMuzzlePlaneAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      var local2:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local2.material.resolution = FlamethrowerEffectsParams.PLANE_LENGTH / param1.frameWidth;
      return local2;
    }

    public function initColorTransform(param1:Vector.<ColorTransformEntry>) : void {
      var local2:StreamWeaponSFXData = StreamWeaponSFXData(getData(StreamWeaponSFXData));
      local2.particleColorTransformPoints = param1;
    }

    public function objectLoaded() : void {
      var local1:FlameThrowingSFXCC = getInitParam();
      var local2:StreamWeaponSFXData = new StreamWeaponSFXData();
      local2.particleAnimation = getParticleAnimation(local1.fireTexture);
      local2.muzzlePlaneAnimation = getMuzzlePlaneAnimation(local1.muzzlePlaneTexture);
      local2.additionalElementTexture = materialRegistry.getMaterial(local1.buffedFireSparksTexture.data);
      local2.shootingSound = local1.flameSound.sound;
      local2.particleSpeed = FlamethrowerEffectsParams.PARTICLE_SPEED_PER_DISTANCE_METER;
      var local3:LightingSfx = new LightingSfx(local1.lightingSFXEntity);
      local2.startLightAnimation = local3.createAnimation("start");
      local2.loopLightAnimation = local3.createAnimation("loop");
      local2.startFireAnimation = local3.createAnimation("startFire");
      local2.loopFireAnimation = local3.createAnimation("loopFire");
      putData(StreamWeaponSFXData,local2);
    }

    public function objectUnloaded() : void {
      var local4:TextureMaterial = null;
      var local1:StreamWeaponSFXData = StreamWeaponSFXData(getData(StreamWeaponSFXData));
      var local2:Array = local1.getMaterialsToRelease();
      var local3:int = 0;
      while(local3 < local2.length) {
        local4 = local2[local3];
        materialRegistry.releaseMaterial(local4);
        local3++;
      }
    }

    public function getFlamethrowerEffects(param1:Number, param2:Number) : StreamWeaponEffects {
      var local3:StreamWeaponSFXData = StreamWeaponSFXData(getData(StreamWeaponSFXData));
      return new FlamethrowerEffects(battleService.getObjectPool(),param1,param2,local3);
    }
  }
}
