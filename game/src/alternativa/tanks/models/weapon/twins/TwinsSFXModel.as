package alternativa.tanks.models.weapon.twins {
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
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.ITwinsShootSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.TwinsShootSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.TwinsShootSFXModelBase;

  [ModelInfo]
  public class TwinsSFXModel extends TwinsShootSFXModelBase implements ITwinsShootSFXModelBase, ObjectLoadPostListener, ObjectUnloadListener, ITwinsSFXModel {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    public function TwinsSFXModel() {
      super();
    }

    private static function getMuzzleFlashMaterial(param1:BitmapData) : TextureMaterial {
      var local2:TextureMaterial = materialRegistry.getMaterial(param1);
      local2.resolution = TwinsEffects.FLASH_SIZE / param1.height;
      return local2;
    }

    private static function getPlasmaAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      return getTextureAnimation(param1,TwinsShotParams.SPRITE_SIZE);
    }

    private static function getExplosionAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      return getTextureAnimation(param1,TwinsShotParams.EXPLOSION_SPRITE_SIZE);
    }

    private static function getTextureAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation {
      var local3:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local3.material.resolution = param2 / param1.frameWidth;
      return local3;
    }

    private static function releaseMaterials(param1:TwinsSFXData) : void {
      materialRegistry.releaseMaterial(param1.muzzleFlashMaterial);
      materialRegistry.releaseMaterial(param1.shotAnimation.material);
      materialRegistry.releaseMaterial(param1.explosionAnimation.material);
      materialRegistry.releaseMaterial(param1.hitMarkMaterial);
    }

    public function getPlasmaWeaponEffects() : TwinsEffects {
      return TwinsEffects(getData(TwinsEffects));
    }

    public function getSFXData() : TwinsSFXData {
      return TwinsSFXData(getData(TwinsSFXData));
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:TwinsShootSFXCC = getInitParam();
      var local2:TwinsSFXData = new TwinsSFXData();
      local2.muzzleFlashMaterial = getMuzzleFlashMaterial(local1.muzzleFlashTexture.data);
      local2.shotAnimation = getPlasmaAnimation(local1.shotTexture);
      local2.explosionAnimation = getExplosionAnimation(local1.explosionTexture);
      local2.hitMarkMaterial = materialRegistry.getMaterial(local1.hitMarkTexture.data);
      local2.shotSound = local1.shotSound.sound;
      var local3:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
      local2.shotLightingAnimation = local3.createAnimation("shot");
      local2.shellLightingAnimation = local3.createAnimation("bullet");
      local2.hitLightingAnimation = local3.createAnimation("hit");
      putData(TwinsSFXData,local2);
      putData(TwinsEffects,new TwinsEffects(battleService,local2));
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      releaseMaterials(this.getSFXData());
    }
  }
}
