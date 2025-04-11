package alternativa.tanks.models.weapon.railgun {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.media.Sound;

  public class RailgunSFXData {
    public var trailMaterial:TextureMaterial;
    public var smokeMaterial:TextureMaterial;
    public var chargingAnimation:TextureAnimation;
    public var ringsAnimation:TextureAnimation;
    public var sphereAnimation:TextureAnimation;
    public var hitMarkMaterial:TextureMaterial;
    public var sound:Sound;
    public var powAnimation:TextureAnimation;
    public var chargeLightAnimation:LightAnimation;
    public var shotLightAnimation:LightAnimation;
    public var hitLightAnimation:LightAnimation;
    public var railLightAnimation:LightAnimation;

    public function RailgunSFXData() {
      super();
    }
  }
}
