package alternativa.tanks.models.weapon.twins {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.media.Sound;

  public class TwinsSFXData {
    public var shotAnimation:TextureAnimation;
    public var explosionAnimation:TextureAnimation;
    public var muzzleFlashMaterial:TextureMaterial;
    public var shotSound:Sound;
    public var hitMarkMaterial:TextureMaterial;
    public var shotLightingAnimation:LightAnimation;
    public var shellLightingAnimation:LightAnimation;
    public var hitLightingAnimation:LightAnimation;

    public function TwinsSFXData() {
      super();
    }
  }
}
