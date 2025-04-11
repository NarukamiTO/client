package alternativa.tanks.models.weapon.streamweapon {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.colortransform.ColorTransformEntry;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.media.Sound;

  public class StreamWeaponSFXData {
    private var _particleAnimation:TextureAnimation;
    private var _muzzlePlaneAnimation:TextureAnimation;
    private var _additionalElementTexture:TextureMaterial;

    public var shootingSound:Sound;
    public var particleColorTransformPoints:Vector.<ColorTransformEntry>;
    public var muzzlePlaneColorTransformPoints:Vector.<ColorTransformEntry>;
    public var particleSpeed:Number;
    public var startLightAnimation:LightAnimation;
    public var loopLightAnimation:LightAnimation;
    public var startFireAnimation:LightAnimation;
    public var loopFireAnimation:LightAnimation;

    public function StreamWeaponSFXData() {
      super();
    }

    public function getParticleAnimation(param1:Boolean) : TextureAnimation {
      return this._particleAnimation;
    }

    public function getMuzzlePlaneAnimation(param1:Boolean) : TextureAnimation {
      return this._muzzlePlaneAnimation;
    }

    public function getAdditionalElementTexture() : TextureMaterial {
      return this._additionalElementTexture;
    }

    public function set particleAnimation(param1:TextureAnimation) : void {
      this._particleAnimation = param1;
    }

    public function set muzzlePlaneAnimation(param1:TextureAnimation) : void {
      this._muzzlePlaneAnimation = param1;
    }

    public function set additionalElementTexture(param1:TextureMaterial) : void {
      this._additionalElementTexture = param1;
    }

    public function getMaterialsToRelease() : Array {
      return [this._particleAnimation.material,this._muzzlePlaneAnimation.material,this._additionalElementTexture];
    }
  }
}
