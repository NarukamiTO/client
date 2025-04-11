package alternativa.tanks.models.tank.ultimate.mammoth {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;
  import flash.geom.Vector3D;

  public class ExplosionEffect extends PooledObject implements GraphicEffect {
    private static const SIZE:int = 700;

    public static const OFFSET:Number = 200;
    public static const MIN:Number = 0.5;
    public static const DIS:Number = 0.82;

    private static const FLASH_NUM:int = 3;
    private static const vector:Vector3D = new Vector3D();

    private var container:Scene3DContainer;
    private var x:Number;
    private var y:Number;
    private var z:Number;
    private var sprite:Sprite3D;
    private var time:Number;
    private var flashNum:int;

    public function ExplosionEffect(param1:Pool) {
      super(param1);
      this.sprite = new Sprite3D(SIZE,SIZE);
      this.sprite.useLight = false;
      this.sprite.useShadowMap = false;
      this.sprite.originY = 0.7;
      this.sprite.blendMode = BlendMode.ADD;
      this.sprite.softAttenuation = 200;
    }

    public function init(param1:TextureMaterial, param2:Number, param3:Number, param4:Number) : * {
      this.x = param2;
      this.y = param3;
      this.z = param4;
      this.sprite.material = param1;
      this.sprite.scaleX = MIN;
      this.sprite.scaleY = MIN;
      this.sprite.scaleZ = MIN;
      this.time = 0;
      this.flashNum = FLASH_NUM;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.sprite);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = param1 / 1000;
      this.time += local3;
      vector.x = param2.x - this.x;
      vector.y = param2.y - this.y;
      vector.z = param2.z - this.z;
      vector.normalize();
      this.sprite.x = this.x + vector.x * OFFSET;
      this.sprite.y = this.y + vector.y * OFFSET;
      this.sprite.z = this.z + vector.z * OFFSET;
      var local4:Number = local3 * 60 / 15 / 2;
      this.sprite.scaleX += local4;
      this.sprite.scaleY += local4;
      this.sprite.scaleZ += local4;
      if(this.sprite.scaleX > DIS) {
        this.sprite.alpha = 1 - (this.sprite.scaleX - DIS) / (1 - DIS);
      } else {
        this.sprite.alpha = 1;
      }
      if(this.sprite.scaleX <= 1) {
        return true;
      }
      --this.flashNum;
      if(this.flashNum > 0) {
        this.sprite.scaleX = MIN;
        this.sprite.scaleY = MIN;
        this.sprite.scaleZ = MIN;
        this.time = 0;
        return true;
      }
      return false;
    }

    public function destroy() : void {
      this.container.removeChild(this.sprite);
      this.sprite.material = null;
      this.container = null;
      recycle();
    }

    public function kill() : void {
      this.sprite.alpha = 0;
    }
  }
}
