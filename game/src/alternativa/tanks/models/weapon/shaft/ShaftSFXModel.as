package alternativa.tanks.models.weapon.shaft {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.models.weapon.shaft.sfx.TrailEffect1;
  import alternativa.tanks.utils.GraphicsUtils;
  import flash.display.BitmapData;
  import flash.media.Sound;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.IShaftShootSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.ShaftShootSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.ShaftShootSFXModelBase;

  [ModelInfo]
  public class ShaftSFXModel extends ShaftShootSFXModelBase implements IShaftShootSFXModelBase, IShaftSFXModel, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    public function ShaftSFXModel() {
      super();
    }

    private static function getTextureAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation {
      var local3:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local3.material.resolution = param2 / param1.frameWidth;
      return local3;
    }

    private static function getTrailMaterial(param1:BitmapData) : TextureMaterial {
      var local2:TextureMaterial = materialRegistry.getMaterial(param1);
      local2.resolution = TrailEffect1.WIDTH / param1.width;
      return local2;
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:ShaftShootSFXCC = getInitParam();
      var local2:Sound = local1.targetingSound.sound;
      var local3:Sound = local1.zoomModeSound.sound;
      var local4:Sound = local1.shotSound.sound;
      var local5:Sound = local1.explosionSound.sound;
      var local6:TextureAnimation = getTextureAnimation(local1.muzzleFlashTexture,ShaftEffects.MUZZLE_FLASH_SIZE);
      var local7:TextureAnimation = getTextureAnimation(local1.explosionTexture,ShaftEffects.EXPLOSION_WIDTH);
      var local8:TextureMaterial = getTrailMaterial(local1.trailTexture.data);
      var local9:TextureMaterial = materialRegistry.getMaterial(local1.hitMarkTexture.data);
      var local10:Number = 500;
      var local11:ShaftSFXData = new ShaftSFXData(local4,local5,local3,local2,local6,local8,local7,local9,local10);
      var local12:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
      local11.shotLightAnimation = local12.createAnimation("shot");
      local11.hitLightAnimation = local12.createAnimation("hit");
      putData(ShaftSFXData,local11);
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      var local1:ShaftSFXData = ShaftSFXData(getData(ShaftSFXData));
      materialRegistry.releaseMaterial(local1.trailMaterial);
      materialRegistry.releaseMaterial(local1.muzzleFlashAnimation.material);
      materialRegistry.releaseMaterial(local1.explosionAnimation.material);
      materialRegistry.releaseMaterial(local1.hitMarkMaterial);
    }

    public function getEffects() : ShaftEffects {
      var local1:ShaftSFXData = ShaftSFXData(getData(ShaftSFXData));
      return new ShaftEffects(local1,battleService);
    }
  }
}
