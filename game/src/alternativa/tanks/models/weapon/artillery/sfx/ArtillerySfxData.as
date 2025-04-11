package alternativa.tanks.models.weapon.artillery.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.sfx.LightAnimation;
  import alternativa.tanks.utils.GraphicsUtils;
  import flash.media.Sound;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx.ArtillerySfxCC;

  public class ArtillerySfxData implements AutoClosable {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    public var explosion:TextureAnimation;
    public var smoke:TextureAnimation;
    public var trail:TextureMaterial;
    public var stream:TextureMaterial;
    public var flame:TextureMaterial;
    public var explosionMarkMaterial:TextureMaterial;
    public var shotLightAnimation:LightAnimation;
    public var hitLightAnimation:LightAnimation;
    public var explosionSound:Sound;
    public var reloadSound:Sound;
    public var flyBySound:Sound;
    public var chargingSound:Sound;
    public var shotSounds:Vector.<Sound>;
    public var farShotSound:Sound;

    public function ArtillerySfxData(param1:IGameObject, param2:ArtillerySfxCC, param3:LightingSfx) {
      super();
      this.explosion = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param2.explosionTexture);
      this.smoke = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param2.smokeTexture);
      this.trail = materialRegistry.getMaterial(param2.trailTexture.data);
      this.stream = materialRegistry.getMaterial(param2.streamTexture.data);
      this.flame = materialRegistry.getMaterial(param2.flameTexture.data);
      this.explosionMarkMaterial = materialRegistry.getMaterial(param2.markTexture.data);
      this.shotLightAnimation = param3.createAnimation("shot");
      this.hitLightAnimation = param3.createAnimation("hit");
      this.explosionSound = param2.explosionSound.sound;
      this.reloadSound = param2.reloadSound.sound;
      this.flyBySound = param2.flyBySound.sound;
      this.chargingSound = param2.chargingSound.sound;
      this.shotSounds = Vector.<Sound>([param2.shot1Sound.sound,param2.shot2Sound.sound,param2.shot3Sound.sound,param2.shot4Sound.sound]);
      this.farShotSound = param2.farShotSound.sound;
    }

    public function close() : void {
      materialRegistry.releaseMaterial(this.explosion.material);
      materialRegistry.releaseMaterial(this.smoke.material);
      materialRegistry.releaseMaterial(this.trail);
      materialRegistry.releaseMaterial(this.stream);
      materialRegistry.releaseMaterial(this.flame);
      materialRegistry.releaseMaterial(this.explosionMarkMaterial);
      this.hitLightAnimation = null;
      this.shotLightAnimation = null;
      var local1:int = 0;
      while(local1 < this.shotSounds.length) {
        this.shotSounds[local1] = null;
        local1++;
      }
      this.chargingSound = null;
      this.explosionSound = null;
      this.reloadSound = null;
      this.flyBySound = null;
      this.farShotSound = null;
    }
  }
}
