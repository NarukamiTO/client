package alternativa.tanks.models.weapon.rocketlauncher.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.sfx.LightAnimation;
  import alternativa.tanks.utils.GraphicsUtils;
  import flash.media.Sound;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.sfx.RocketLauncherSfxCC;

  public class RocketLauncherSfxData implements AutoClosable {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    public var explosion:TextureAnimation;
    public var explosionMark:TextureMaterial;
    public var rocketTexture:TextureMaterial;
    public var rocketFlame:TextureMaterial;
    public var rocketSmoke:TextureMaterial;
    public var shotSounds:Vector.<Sound>;
    public var hitSounds:Vector.<Sound>;
    public var rocketFlightSound:Sound;
    public var aimingSound:Sound;
    public var targetLostSound:Sound;
    public var aimingCompleteSound:Sound;
    public var rocketLightingAnimation:LightAnimation;
    public var explosionLightingAnimation:LightAnimation;

    public function RocketLauncherSfxData(param1:RocketLauncherSfxCC, param2:LightingSfx) {
      super();
      this.explosion = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1.explosionTexture);
      this.explosionMark = materialRegistry.getMaterial(param1.explosionMarkTexture.data);
      this.rocketTexture = materialRegistry.getMaterial(param1.rocketTexture.data);
      this.rocketFlame = materialRegistry.getMaterial(param1.rocketFlameTexture.data);
      this.rocketSmoke = materialRegistry.getMaterial(param1.rocketSmokeTexture.data);
      this.shotSounds = Vector.<Sound>([param1.rightShotSounds.sound,param1.leftShotSounds.sound]);
      this.hitSounds = Vector.<Sound>([param1.rightHitSounds.sound,param1.leftHitSounds.sound]);
      this.rocketFlightSound = param1.rocketFlightSound.sound;
      this.aimingSound = param1.aimingSound.sound;
      this.targetLostSound = param1.targetLostSound.sound;
      this.aimingCompleteSound = param1.aimingCompleteSound.sound;
      this.rocketLightingAnimation = param2.createAnimation("rocket");
      this.explosionLightingAnimation = param2.createAnimation("explosion");
    }

    public function close() : void {
      var local1:int = 0;
      materialRegistry.releaseMaterial(this.explosion.material);
      materialRegistry.releaseMaterial(this.explosionMark);
      materialRegistry.releaseMaterial(this.rocketTexture);
      materialRegistry.releaseMaterial(this.rocketFlame);
      materialRegistry.releaseMaterial(this.rocketSmoke);
      local1 = 0;
      while(local1 < this.shotSounds.length) {
        this.shotSounds[local1] = null;
        local1++;
      }
      this.shotSounds = null;
      local1 = 0;
      while(local1 < this.hitSounds.length) {
        this.hitSounds[local1] = null;
        local1++;
      }
      this.hitSounds = null;
      this.rocketFlightSound = null;
      this.aimingSound = null;
      this.targetLostSound = null;
      this.aimingCompleteSound = null;
      this.rocketLightingAnimation = null;
      this.explosionLightingAnimation = null;
    }
  }
}
