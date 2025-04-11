package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.media.Sound;

  public class GaussSFXData {
    public var electroTextureMaterial:TextureMaterial;
    public var explosionElectroTextureAnimation:TextureAnimation;
    public var explosionTextureAnimation:TextureAnimation;
    public var fireTextureMaterial:TextureMaterial;
    public var flameTextureMaterial:TextureMaterial;
    public var lightningTextureMaterial:TextureMaterial;
    public var tracerTextureMaterial:TextureMaterial;
    public var trailTextureMaterial:TextureMaterial;
    public var smokeTextureMaterial:TextureMaterial;
    public var primaryHitMarkerMaterial:TextureMaterial;
    public var shellMesh:Mesh;
    public var primaryShotLightAnimation:LightAnimation;
    public var primaryExplosionLightAnimation:LightAnimation;
    public var primaryShellLightAnimation:LightAnimation;
    public var secondaryShotLightAnimation:LightAnimation;
    public var secondaryExplosionLightAnimation:LightAnimation;
    public var secondaryLightningLightAnimation:LightAnimation;
    public var primaryHitSound:Sound;
    public var primaryShotSound:Sound;
    public var secondaryHitSound:Sound;
    public var secondaryShotSound:Sound;
    public var antennaUpSound:Sound;
    public var antennaDownSound:Sound;
    public var startAimingSound:Sound;
    public var targetLockSound:Sound;
    public var targetLostSound:Sound;
    public var shellFlightSound:Sound;
    public var powerShotFarSounds:Vector.<Sound>;

    public function GaussSFXData() {
      super();
    }
  }
}
