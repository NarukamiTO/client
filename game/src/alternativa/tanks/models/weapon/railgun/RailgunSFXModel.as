package alternativa.tanks.models.weapon.railgun {
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
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.IRailgunShootSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.RailgunShootSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.RailgunShootSFXModelBase;

  [ModelInfo]
  public class RailgunSFXModel extends RailgunShootSFXModelBase implements IRailgunShootSFXModelBase, IRailgunSFXModel, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    private const chargingTextureRegistry:ChargingTextureRegistry = new ChargingTextureRegistry();

    public function RailgunSFXModel() {
      super();
    }

    private static function getTextureAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation {
      var local3:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local3.material.resolution = param2 / param1.frameWidth;
      return local3;
    }

    private static function getTrailMaterial(param1:BitmapData) : TextureMaterial {
      var local2:TextureMaterial = materialRegistry.getMaterial(param1);
      local2.repeat = true;
      local2.mipMapping = 0;
      return local2;
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:RailgunShootSFXCC = getInitParam();
      var local2:RailgunSFXData = new RailgunSFXData();
      local2.trailMaterial = getTrailMaterial(local1.trailImage.data);
      local2.smokeMaterial = getTrailMaterial(local1.smokeImage.data);
      local2.hitMarkMaterial = materialRegistry.getMaterial(local1.hitMarkTexture.data);
      local2.chargingAnimation = this.getChargingAnimation(local1.chargingPart1,local1.chargingPart2,local1.chargingPart3);
      local2.ringsAnimation = getTextureAnimation(local1.ringsTexture,RailgunEffects.RINGS_SIZE);
      local2.sphereAnimation = getTextureAnimation(local1.sphereTexture,RailgunEffects.SPHERE_SIZE);
      local2.powAnimation = getTextureAnimation(local1.powTexture,RailgunEffects.POW_WIDTH);
      local2.sound = local1.shotSound.sound;
      var local3:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
      local2.chargeLightAnimation = local3.createAnimation("charge");
      local2.shotLightAnimation = local3.createAnimation("shot");
      local2.hitLightAnimation = local3.createAnimation("hit");
      local2.railLightAnimation = local3.createAnimation("rail");
      putData(RailgunSFXData,local2);
    }

    private function getChargingAnimation(param1:TextureResource, param2:TextureResource, param3:TextureResource) : TextureAnimation {
      var local4:BitmapData = this.chargingTextureRegistry.getTexture(param1,param2,param3);
      var local5:int = local4.height;
      var local6:TextureAnimation = GraphicsUtils.getTextureAnimation(materialRegistry,local4,local5,local5);
      local6.material.resolution = RailgunEffects.CHARGE_EFFECT_SIZE / local5;
      return local6;
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      var local1:RailgunSFXData = RailgunSFXData(getData(RailgunSFXData));
      materialRegistry.releaseMaterial(local1.trailMaterial);
      materialRegistry.releaseMaterial(local1.smokeMaterial);
      materialRegistry.releaseMaterial(local1.chargingAnimation.material);
      materialRegistry.releaseMaterial(local1.hitMarkMaterial);
      materialRegistry.releaseMaterial(local1.ringsAnimation.material);
      materialRegistry.releaseMaterial(local1.sphereAnimation.material);
      materialRegistry.releaseMaterial(local1.powAnimation.material);
    }

    public function getEffects() : IRailgunEffects {
      return new RailgunEffects(RailgunSFXData(getData(RailgunSFXData)),battleService);
    }
  }
}
