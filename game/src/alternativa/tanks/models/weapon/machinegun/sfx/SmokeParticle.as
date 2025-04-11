package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.math.Vector3;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;

  public class SmokeParticle extends Particle {
    private var _rotation:Number;
    private var _initialZ:Number;
    private var _sprite:AnimatedSprite3D = new AnimatedSprite3D(1,1);

    public function SmokeParticle(param1:Pool) {
      super(param1);
      SFXUtils.setEffectParams(this._sprite);
    }

    public function init(param1:Number, param2:Vector3, param3:Number, param4:TextureAnimation) : void {
      this._sprite.width = param1;
      this._sprite.height = param1;
      this._sprite.setAnimationData(param4);
      this._sprite.x = param2.x;
      this._sprite.y = param2.y;
      this._sprite.z = param2.z;
      this._sprite.rotation = param3;
      this._rotation = param3;
      this._initialZ = param2.z;
    }

    public function get sprite() : AnimatedSprite3D {
      return this._sprite;
    }

    public function get rotation() : Number {
      return this._rotation;
    }

    public function get initialZ() : Number {
      return this._initialZ;
    }
  }
}
