package alternativa.tanks.sfx.levelup {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class LightWaveEffect extends PooledObject implements GraphicEffect {
    private static const vector:Vector3 = new Vector3();

    private var wave:Sprite3D;
    private var delay:int;
    private var time:int;
    private var maxScale:Number;
    private var direction:Boolean;
    private var turret:Object3D;
    private var state:int;
    private var container:Scene3DContainer;

    public function LightWaveEffect(param1:Pool) {
      super(param1);
      this.wave = new Sprite3D(10,10);
      this.wave.blendMode = BlendMode.ADD;
    }

    public function init(param1:int, param2:Number, param3:Number, param4:Boolean, param5:Object3D, param6:TextureMaterial) : void {
      this.delay = param1;
      this.wave.width = param2;
      this.wave.height = param2;
      this.wave.calculateBounds();
      this.maxScale = param3;
      this.direction = param4;
      this.turret = param5;
      param6.resolution = 5;
      this.wave.material = param6;
      this.wave.scaleX = 1;
      this.wave.scaleY = 1;
      this.wave.scaleZ = 1;
      this.wave.rotation = 0;
      this.wave.alpha = 0;
      this.state = 0;
      this.wave.softAttenuation = 150;
      this.wave.depthMapAlphaThreshold = 2;
      this.wave.shadowMapAlphaThreshold = 2;
      this.wave.useShadowMap = false;
      this.wave.useLight = false;
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.wave);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      if(this.state == 2) {
        return false;
      }
      var local3:Number = 0.7 * 5;
      var local4:Number = local3 / 3;
      var local5:Number = 0.2;
      local6 = 300;
      vector.x = param2.x - this.turret.x;
      vector.y = param2.y - this.turret.y;
      vector.z = param2.z - this.turret.z;
      vector.normalize();
      vector.scale(local6);
      this.wave.x = this.turret.x + vector.x;
      this.wave.y = this.turret.y + vector.y;
      this.wave.z = this.turret.z + vector.z + 30;
      this.time += param1;
      if(this.time >= this.delay) {
        if(this.direction) {
          this.wave.rotation += local5 * param1 * 0.001;
        } else {
          this.wave.rotation -= local5 * param1 * 0.001;
        }
        if(this.state == 0) {
          local7 = local3 * param1 * 0.001;
          this.wave.scaleX += local7;
          this.wave.scaleY += local7;
          this.wave.scaleZ += local7;
          if(this.wave.scaleX > this.maxScale) {
            this.wave.scaleX = this.maxScale;
            this.wave.scaleY = this.maxScale;
            this.wave.scaleZ = this.maxScale;
            this.state = 1;
          }
          this.wave.alpha = (this.wave.scaleX - 1) / (this.maxScale - 1);
        } else if(this.state == 1) {
          local8 = local4 * param1 * 0.001;
          this.wave.scaleX -= local8;
          this.wave.scaleY -= local8;
          this.wave.scaleZ -= local8;
          if(this.wave.scaleX < 1) {
            this.wave.scaleX = 1;
            this.wave.scaleY = 1;
            this.wave.scaleZ = 1;
            this.state = 2;
          }
          this.wave.alpha = (this.wave.scaleX - 1) / (this.maxScale - 1) - 0.1;
        }
      }
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.wave);
      this.container = null;
      this.wave.material = null;
      recycle();
    }

    public function kill() : void {
      this.state = 2;
      this.wave.alpha = 0;
    }
  }
}
