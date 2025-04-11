package alternativa.tanks.models.battle.meteor {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class MeteorSmoke extends PooledObject implements GraphicEffect {
    internal const INITIAL_ALPHA:Number = 0.4;
    internal const SCALE_STEP:Number = 0.04;
    internal const ALPHA_STEP:Number = 0.002;
    internal const MEAN_FPS:Number = 50;
    internal const STEP_COEFF_MS:Number = 0.05;
    internal const WIDTH:Number = 200;
    internal const HEIGHT:Number = 200;

    private var sprite:Sprite3D;
    private var container:Scene3DContainer;

    public function MeteorSmoke(param1:Pool) {
      super(param1);
      this.sprite = new Sprite3D(this.WIDTH,this.HEIGHT);
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      this.container.addChild(this.sprite);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = this.SCALE_STEP * this.STEP_COEFF_MS * param1;
      this.sprite.scaleX += local3;
      this.sprite.scaleY += local3;
      this.sprite.scaleZ += local3;
      this.sprite.alpha -= this.ALPHA_STEP * this.STEP_COEFF_MS * param1;
      return this.sprite.alpha > 0;
    }

    public function destroy() : void {
      if(this.container != null) {
        this.container.removeChild(this.sprite);
        this.container = null;
      }
      this.sprite.material = null;
      recycle();
    }

    public function kill() : void {
      this.sprite.alpha = 0;
    }

    public function init(param1:Vector3, param2:Vector3, param3:TextureMaterial) : void {
      this.sprite.material = param3;
      this.sprite.rotation = Math.random() * Math.PI * 2;
      this.sprite.scaleX = 1;
      this.sprite.scaleY = 1;
      this.sprite.scaleZ = 1;
      this.sprite.alpha = this.INITIAL_ALPHA;
      this.sprite.x = param1.x - param2.x * 40;
      this.sprite.y = param1.y - param2.y * 40;
      this.sprite.z = param1.z - param2.z * 40;
    }
  }
}
