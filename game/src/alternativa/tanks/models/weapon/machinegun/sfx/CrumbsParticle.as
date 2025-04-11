package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;

  public class CrumbsParticle extends Particle {
    private var _sprite:Sprite3D = new Sprite3D(1,1);
    private var _direction:Vector3 = new Vector3();
    private var _time:Number = 0;

    public function CrumbsParticle(param1:Pool) {
      super(param1);
      SFXUtils.setEffectParams(this._sprite);
    }

    public function init(param1:Number, param2:Vector3, param3:Vector3, param4:TextureMaterial) : void {
      this._time = 0;
      this._direction.copy(param3);
      this._sprite.width = param1;
      this._sprite.height = param1;
      this._sprite.x = param2.x;
      this._sprite.y = param2.y;
      this._sprite.z = param2.z;
      this._sprite.material = param4;
    }

    public function get sprite() : Sprite3D {
      return this._sprite;
    }

    public function get direction() : Vector3 {
      return this._direction;
    }

    public function get time() : Number {
      return this._time;
    }

    public function set time(param1:Number) : void {
      this._time = param1;
    }
  }
}
