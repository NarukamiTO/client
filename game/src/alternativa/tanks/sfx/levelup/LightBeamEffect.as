package alternativa.tanks.sfx.levelup {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class LightBeamEffect extends PooledObject implements GraphicEffect {
    private static const BASE_SIZE:Number = 300;

    private var beam:LightBeam;
    private var delay:int;
    private var time:int;
    private var height:Number;
    private var maxHeight:Number;
    private var heightSpeed:Number;
    private var fadeSpeed:Number;
    private var x:Number;
    private var y:Number;
    private var z:Number;
    private var turret:Object3D;
    private var container:Scene3DContainer;

    public function LightBeamEffect(param1:Pool) {
      super(param1);
      this.beam = new LightBeam(BASE_SIZE);
      this.beam.blendMode = BlendMode.ADD;
    }

    public function init(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Object3D, param11:TextureMaterial) : void {
      this.delay = param1;
      this.beam.scaleX = param2 / BASE_SIZE;
      this.height = param3;
      this.maxHeight = param4;
      this.heightSpeed = param5;
      this.fadeSpeed = param6;
      this.x = param7;
      this.y = param8;
      this.z = param9;
      this.turret = param10;
      this.beam.init(param11);
      this.beam.softAttenuation = 150;
      this.beam.depthMapAlphaThreshold = 2;
      this.beam.shadowMapAlphaThreshold = 2;
      this.beam.useShadowMap = false;
      this.beam.useLight = false;
      this.beam.alpha = 0;
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.beam);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.height >= this.maxHeight && this.beam.alpha <= 0) {
        return false;
      }
      this.beam.x = this.turret.x + this.x;
      this.beam.y = this.turret.y + this.y;
      this.beam.z = this.turret.z + this.z;
      this.beam.rotationZ = param2.rotationZ;
      this.time += param1;
      if(this.time >= this.delay) {
        if(this.height < this.maxHeight) {
          this.height += this.maxHeight * this.heightSpeed * param1 * 0.001;
          if(this.height >= this.maxHeight) {
            this.height = this.maxHeight;
          }
          this.beam.scaleZ = this.height / BASE_SIZE;
          this.beam.alpha = this.height / this.maxHeight;
        } else {
          this.beam.alpha -= this.fadeSpeed * param1 * 0.001;
          if(this.beam.alpha < 0) {
            this.beam.alpha = 0;
          }
        }
      }
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.beam);
      this.container = null;
      this.turret = null;
      this.beam.clear();
      recycle();
    }

    public function kill() : void {
      this.height = this.maxHeight;
      this.beam.alpha = 0;
    }
  }
}
