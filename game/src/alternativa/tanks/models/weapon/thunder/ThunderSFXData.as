package alternativa.tanks.models.weapon.thunder {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.media.Sound;

  public class ThunderSFXData {
    public var muzzleFlashMaterial:TextureMaterial;
    public var explosionAnimation:TextureAnimation;
    public var shotSound:Sound;
    public var explosionSound:Sound;
    public var explosionSize:Number;
    public var explosionMarkMaterial:TextureMaterial;
    public var shotLightAnimation:LightAnimation;
    public var hitLightAnimation:LightAnimation;

    public function ThunderSFXData() {
      super();
    }
  }
}
