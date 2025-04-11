package alternativa.tanks.models.weapon.ricochet {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.utils.GraphicsUtils;
  import flash.display.BitmapData;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.IRicochetSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.RicochetSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.RicochetSFXModelBase;

  [ModelInfo]
  public class RicochetSFXModel extends RicochetSFXModelBase implements IRicochetSFXModelBase, ObjectLoadPostListener, ObjectUnloadListener, IRicochetSFXModel {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    public function RicochetSFXModel() {
      super();
    }

    private static function getShotAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      return getTextureAnimation(param1,RicochetShot.SPRITE_SIZE);
    }

    private static function getTextureAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation {
      var local3:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local3.material.resolution = param2 / param1.frameWidth;
      return local3;
    }

    private static function getExplosionAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      return getTextureAnimation(param1,RicochetShot.EXPLOSION_SPRITE_SIZE);
    }

    private static function getBumpFlashAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      return getTextureAnimation(param1,RicochetShot.EXPLOSION_SPRITE_SIZE);
    }

    private static function getMuzzleFlashMaterial(param1:TextureResource) : TextureMaterial {
      var local2:BitmapData = param1.data;
      var local3:TextureMaterial = materialRegistry.getMaterial(local2);
      local3.resolution = RicochetEffects.MUZZLE_FLASH_SIZE / local2.height;
      return local3;
    }

    private static function getTrailMaterial(param1:BitmapData) : TextureMaterial {
      var local2:TextureMaterial = materialRegistry.getMaterial(param1);
      local2.resolution = RicochetShot.TRAIL_WIDTH / param1.height;
      return local2;
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:RicochetSFXCC = getInitParam();
      var local2:RicochetSFXData = new RicochetSFXData();
      local2.shotAnimation = getShotAnimation(local1.shotTexture);
      local2.explosionAnimation = getExplosionAnimation(local1.explosionTexture);
      local2.ricochetFlashAnimation = getBumpFlashAnimation(local1.bumpFlashTexture);
      local2.muzzleFlashMaterial = getMuzzleFlashMaterial(local1.shotFlashTexture);
      local2.tailTrailMaterial = getTrailMaterial(local1.tailTrailTexutre.data);
      local2.shotSound = local1.shotSound.sound;
      local2.ricochetSound = local1.ricochetSound.sound;
      local2.explosionSound = local1.explostinSound.sound;
      var local3:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
      local2.shotLightAnimation = local3.createAnimation("shot");
      local2.ricochetLightAnimation = local3.createAnimation("ricochet");
      local2.hitLightAnimation = local3.createAnimation("hit");
      local2.shellLightAnimation = local3.createAnimation("bullet");
      putData(RicochetSFXData,local2);
      putData(RicochetEffects,new RicochetEffects(battleService,local2));
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      var local1:RicochetSFXData = this.getSfxData();
      materialRegistry.releaseMaterial(local1.explosionAnimation.material);
      materialRegistry.releaseMaterial(local1.ricochetFlashAnimation.material);
      materialRegistry.releaseMaterial(local1.shotAnimation.material);
      materialRegistry.releaseMaterial(local1.muzzleFlashMaterial);
      materialRegistry.releaseMaterial(local1.tailTrailMaterial);
    }

    public function getSfxData() : RicochetSFXData {
      return RicochetSFXData(getData(RicochetSFXData));
    }

    public function getRicochetEffects() : RicochetEffects {
      return RicochetEffects(getData(RicochetEffects));
    }
  }
}
