package alternativa.tanks.models.weapon.smoky.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.models.weapon.smoky.ISmokyEffects;
  import alternativa.tanks.models.weapon.smoky.SmokyEffectsParams;
  import alternativa.tanks.utils.GraphicsUtils;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.ISmokyShootSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.SmokyShootSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.SmokyShootSFXModelBase;

  [ModelInfo]
  public class SmokySFXModel extends SmokyShootSFXModelBase implements ISmokyShootSFXModelBase, ISmokySFXModel, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    public function SmokySFXModel() {
      super();
    }

    private static function getMuzzleFlashMaterial(param1:TextureResource) : TextureMaterial {
      var local2:TextureMaterial = materialRegistry.getMaterial(param1.data);
      local2.resolution = SmokyEffectsParams.PLANE_WIDTH / param1.data.height;
      return local2;
    }

    private static function createAnimation(param1:MultiframeTextureResource, param2:int) : TextureAnimation {
      var local3:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local3.material.resolution = param2 / param1.frameWidth;
      return local3;
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:SmokyShootSFXCC = getInitParam();
      var local2:SmokySFXData = new SmokySFXData();
      local2.muzzleFlashMaterial = getMuzzleFlashMaterial(local1.shotTexture);
      local2.explosionAnimation = createAnimation(local1.explosionTexture,local1.explosionSize);
      local2.explosionMarkMaterial = materialRegistry.getMaterial(local1.explosionMarkTexture.data);
      local2.criticalHitAnimation = createAnimation(local1.criticalHitTexture,local1.criticalHitSize);
      local2.criticalHitSize = local1.criticalHitSize;
      local2.shotSound = local1.shotSound.sound;
      local2.explosionSound = local1.explosionSound.sound;
      local2.explosionSize = local1.explosionSize;
      var local3:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
      local2.shotLightAnimation = local3.createAnimation("shot");
      local2.hitLightAnimation = local3.createAnimation("hit");
      putData(SmokySFXData,local2);
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      var local1:SmokySFXData = SmokySFXData(getData(SmokySFXData));
      materialRegistry.releaseMaterial(local1.muzzleFlashMaterial);
      materialRegistry.releaseMaterial(local1.explosionAnimation.material);
      materialRegistry.releaseMaterial(local1.explosionMarkMaterial);
      materialRegistry.releaseMaterial(local1.criticalHitAnimation.material);
    }

    public function getEffects() : ISmokyEffects {
      var local1:SmokySFXData = SmokySFXData(getData(SmokySFXData));
      return new SmokyEffects(battleService.getBattleRunner().getSoundManager(),battleService.getObjectPool(),local1);
    }
  }
}
