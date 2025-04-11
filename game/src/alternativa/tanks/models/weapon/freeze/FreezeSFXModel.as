package alternativa.tanks.models.weapon.freeze {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponSFXData;
  import alternativa.tanks.utils.GraphicsUtils;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.FreezeSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.FreezeSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.IFreezeSFXModelBase;

  [ModelInfo]
  public class FreezeSFXModel extends FreezeSFXModelBase implements IFreezeSFXModelBase, ObjectLoadListener, ObjectUnloadListener, IFreezeSFXModel {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    public function FreezeSFXModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:FreezeSFXCC = getInitParam();
      var local2:StreamWeaponSFXData = new StreamWeaponSFXData();
      local2.particleAnimation = this.getParticleAnimation(local1.particleTextureResource);
      local2.muzzlePlaneAnimation = this.getMuzzlePlaneAnimation(local1.planeTextureResource);
      local2.additionalElementTexture = materialRegistry.getMaterial(local1.buffedShardsTextureResource.data);
      local2.particleSpeed = BattleUtils.toClientScale(local1.particleSpeed);
      local2.shootingSound = local1.shotSoundResource.sound;
      var local3:LightingSfx = new LightingSfx(local1.lightingSFXEntity);
      local2.startLightAnimation = local3.createAnimation("start");
      local2.loopLightAnimation = local3.createAnimation("loop");
      local2.startFireAnimation = local3.createAnimation("startFire");
      local2.loopFireAnimation = local3.createAnimation("loopFire");
      putData(StreamWeaponSFXData,local2);
    }

    private function getParticleAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      var local2:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local2.material.resolution = FreezeEffectsParams.PARTICLE_END_SIZE / param1.frameWidth;
      return local2;
    }

    private function getMuzzlePlaneAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      var local2:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local2.material.resolution = FreezeEffectsParams.PLANE_LENGTH / param1.frameWidth;
      return local2;
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

    public function getFreezeEffects(param1:Number, param2:Number) : StreamWeaponEffects {
      var local3:StreamWeaponSFXData = StreamWeaponSFXData(getData(StreamWeaponSFXData));
      return new FreezeEffects(battleService.getObjectPool(),param1,param2,local3);
    }
  }
}
