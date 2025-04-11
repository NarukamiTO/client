package alternativa.tanks.models.weapon.thunder {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.utils.GraphicsUtils;
  import flash.display.BitmapData;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.IThunderShootSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.ThunderShootSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.ThunderShootSFXModelBase;

  [ModelInfo]
  public class ThunderSFXModel extends ThunderShootSFXModelBase implements IThunderShootSFXModelBase, IThunderSFXModel, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    public function ThunderSFXModel() {
      super();
    }

    private static function getMuzzleFlashMaterial(param1:TextureResource) : TextureMaterial {
      var local2:BitmapData = param1.data;
      var local3:TextureMaterial = materialRegistry.getMaterial(local2);
      local3.resolution = ThunderShotEffect.SPRITE_SIZE_1 / local2.height;
      return local3;
    }

    private static function getExplosionAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation {
      var local3:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local3.material.resolution = param2 / param1.frameWidth;
      return local3;
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:ThunderShootSFXCC = getInitParam();
      var local2:ThunderSFXData = new ThunderSFXData();
      local2.muzzleFlashMaterial = getMuzzleFlashMaterial(local1.shotTexture);
      local2.explosionAnimation = getExplosionAnimation(local1.explosionTexture,local1.explosionSize);
      local2.explosionSize = local1.explosionSize;
      local2.shotSound = local1.shotSound.sound;
      local2.explosionSound = local1.explosionSound.sound;
      local2.explosionMarkMaterial = materialRegistry.getMaterial(local1.explosionMarkTexture.data);
      var local3:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
      local2.shotLightAnimation = local3.createAnimation("shot");
      local2.hitLightAnimation = local3.createAnimation("hit");
      putData(ThunderSFXData,local2);
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      var local1:ThunderSFXData = ThunderSFXData(getData(ThunderSFXData));
      materialRegistry.releaseMaterial(local1.muzzleFlashMaterial);
      materialRegistry.releaseMaterial(local1.explosionAnimation.material);
      materialRegistry.releaseMaterial(local1.explosionMarkMaterial);
    }

    public function getEffects() : IThunderEffects {
      return new ThunderEffects(battleService,ThunderSFXData(getData(ThunderSFXData)));
    }
  }
}
