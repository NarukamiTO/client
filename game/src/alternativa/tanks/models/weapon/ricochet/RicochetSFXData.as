package alternativa.tanks.models.weapon.ricochet {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.media.Sound;

  public class RicochetSFXData {
    public var shotAnimation:TextureAnimation;
    public var muzzleFlashMaterial:TextureMaterial;
    public var ricochetFlashAnimation:TextureAnimation;
    public var explosionAnimation:TextureAnimation;
    public var tailTrailMaterial:TextureMaterial;
    public var shotSound:Sound;
    public var ricochetSound:Sound;
    public var explosionSound:Sound;
    public var shotLightAnimation:LightAnimation;
    public var hitLightAnimation:LightAnimation;
    public var ricochetLightAnimation:LightAnimation;
    public var shellLightAnimation:LightAnimation;

    public function RicochetSFXData() {
      super();
    }
  }
}
