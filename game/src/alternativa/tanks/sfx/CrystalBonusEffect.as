package alternativa.tanks.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CrystalBonusEffect extends PooledObject implements GraphicEffect {
    private var sprite:Sprite3D;
    private var delay:int;
    private var time:int;
    private var maxHeight:Number;
    private var visibleHeight:Number;
    private var heightSpeed:Number;
    private var x:Number;
    private var y:Number;
    private var z:Number;
    private var startPosition:Vector3d;
    private var container:Scene3DContainer;

    public function CrystalBonusEffect(param1:Pool) {
      super(param1);
      this.sprite = new Sprite3D(10,10);
    }

    public function init(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Vector3d, param12:TextureMaterial, param13:String) : void {
      this.delay = param1;
      this.sprite.width = param2;
      this.sprite.height = param3;
      this.sprite.calculateBounds();
      this.sprite.rotation = param4;
      this.maxHeight = param5;
      this.visibleHeight = param6;
      this.heightSpeed = param7;
      this.x = param8;
      this.y = param9;
      this.z = param10;
      this.startPosition = param11;
      param12.resolution = 1;
      this.sprite.material = param12;
      this.sprite.softAttenuation = 150;
      this.sprite.depthMapAlphaThreshold = 2;
      this.sprite.shadowMapAlphaThreshold = 2;
      this.sprite.useShadowMap = false;
      this.sprite.useLight = false;
      this.sprite.blendMode = param13;
      this.sprite.alpha = 0;
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.sprite);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = NaN;
      if(this.z >= this.maxHeight) {
        return false;
      }
      this.sprite.x = this.startPosition.x + this.x;
      this.sprite.y = this.startPosition.y + this.y;
      this.sprite.z = this.startPosition.z + this.z;
      this.time += param1;
      if(this.time >= this.delay) {
        this.z += this.maxHeight * this.heightSpeed * param1 * 0.001;
        if(this.z < this.visibleHeight) {
          this.sprite.alpha = this.z / this.visibleHeight;
        } else {
          local3 = (this.z - this.visibleHeight) / (this.maxHeight - this.visibleHeight);
          this.sprite.alpha = 1 - local3 * local3 * local3 * local3 * local3 * local3 * local3 * local3;
        }
        if(this.sprite.alpha < 0) {
          this.sprite.alpha = 0;
        }
        if(this.sprite.alpha > 1) {
          this.sprite.alpha = 1;
        }
      } else {
        this.sprite.alpha = 0;
      }
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.sprite);
      this.container = null;
      this.sprite.material = null;
      recycle();
    }

    public function kill() : void {
      this.z = this.maxHeight;
      this.sprite.alpha = 0;
    }
  }
}
