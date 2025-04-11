package alternativa.tanks.models.weapon.shaft {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.media.Sound;

  internal class ShaftSFXData {
    public var shotSound:Sound;
    public var explosionSound:Sound;
    public var zoomModeSound:Sound;
    public var targetingSound:Sound;
    public var muzzleFlashAnimation:TextureAnimation;
    public var explosionAnimation:TextureAnimation;
    public var trailMaterial:TextureMaterial;
    public var hitMarkMaterial:TextureMaterial;
    public var trailLength:Number;
    public var shotLightAnimation:LightAnimation;
    public var hitLightAnimation:LightAnimation;

    public function ShaftSFXData(param1:Sound, param2:Sound, param3:Sound, param4:Sound, param5:TextureAnimation, param6:TextureMaterial, param7:TextureAnimation, param8:TextureMaterial, param9:Number) {
      super();
      this.shotSound = param1;
      this.explosionSound = param2;
      this.zoomModeSound = param3;
      this.targetingSound = param4;
      this.muzzleFlashAnimation = param5;
      this.trailMaterial = param6;
      this.explosionAnimation = param7;
      this.hitMarkMaterial = param8;
      this.trailLength = param9;
    }
  }
}
