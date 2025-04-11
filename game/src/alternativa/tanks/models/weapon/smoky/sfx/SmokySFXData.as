package alternativa.tanks.models.weapon.smoky.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.media.Sound;

  public class SmokySFXData {
    public var muzzleFlashMaterial:TextureMaterial;
    public var explosionAnimation:TextureAnimation;
    public var criticalHitAnimation:TextureAnimation;
    public var explosionMarkMaterial:TextureMaterial;
    public var shotSound:Sound;
    public var explosionSound:Sound;
    public var explosionSize:Number;
    public var criticalHitSize:int;
    public var shotLightAnimation:LightAnimation;
    public var hitLightAnimation:LightAnimation;

    public function SmokySFXData() {
      super();
    }
  }
}
