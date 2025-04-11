package alternativa.tanks.sfx.levelup {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class SparkEffect extends PooledObject implements GraphicEffect {
    private var spark:Sprite3D;
    private var delay:int;
    private var time:int;
    private var maxHeight:Number;
    private var visibleHeight:Number;
    private var heightSpeed:Number;
    private var x:Number;
    private var y:Number;
    private var z:Number;
    private var object:Object3D;
    private var container:Scene3DContainer;

    public function SparkEffect(param1:Pool) {
      super(param1);
      this.spark = new Sprite3D(10,10);
    }

    public function init(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Object3D, param12:TextureMaterial, param13:String) : void {
      this.delay = param1;
      this.spark.width = param2;
      this.spark.height = param3;
      this.spark.calculateBounds();
      this.spark.rotation = param4;
      this.maxHeight = param5;
      this.visibleHeight = param6;
      this.heightSpeed = param7;
      this.x = param8;
      this.y = param9;
      this.z = param10;
      this.object = param11;
      this.spark.material = param12;
      this.spark.softAttenuation = 150;
      this.spark.depthMapAlphaThreshold = 2;
      this.spark.shadowMapAlphaThreshold = 2;
      this.spark.useShadowMap = false;
      this.spark.useLight = false;
      this.spark.blendMode = param13;
      this.spark.alpha = 0;
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.spark);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = NaN;
      if(this.z >= this.maxHeight) {
        return false;
      }
      this.spark.x = this.object.x + this.x;
      this.spark.y = this.object.y + this.y;
      this.spark.z = this.object.z + this.z;
      this.time += param1;
      if(this.time >= this.delay) {
        this.z += this.maxHeight * this.heightSpeed * param1 * 0.001;
        if(this.z < this.visibleHeight) {
          this.spark.alpha = this.z / this.visibleHeight;
        } else {
          local3 = (this.z - this.visibleHeight) / (this.maxHeight - this.visibleHeight);
          this.spark.alpha = 1 - local3 * local3 * local3 * local3 * local3 * local3 * local3 * local3;
        }
        if(this.spark.alpha < 0) {
          this.spark.alpha = 0;
        }
        if(this.spark.alpha > 1) {
          this.spark.alpha = 1;
        }
      } else {
        this.spark.alpha = 0;
      }
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.spark);
      this.container = null;
      this.spark.material = null;
      recycle();
    }

    public function kill() : void {
      this.z = this.maxHeight;
      this.spark.alpha = 0;
    }
  }
}
