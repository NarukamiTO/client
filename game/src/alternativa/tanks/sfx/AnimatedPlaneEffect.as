package alternativa.tanks.sfx {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class AnimatedPlaneEffect extends PooledObject implements GraphicEffect {
    private static const BASE_SIZE:Number = 100;

    private var scaleSpeed:Number;

    protected var scale:Number;
    protected var baseScale:Number;
    protected var plane:SquareAnimatedPlane;

    private var currentTime:int;
    private var maxTime:int;
    private var container:Scene3DContainer;

    public function AnimatedPlaneEffect(param1:Pool) {
      super(param1);
      this.plane = new SquareAnimatedPlane(BASE_SIZE);
      this.plane.useShadowMap = false;
      this.plane.useLight = false;
      this.plane.shadowMapAlphaThreshold = 2;
      this.plane.depthMapAlphaThreshold = 2;
      this.plane.softAttenuation = 0;
    }

    public function init(param1:Number, param2:Vector3, param3:Vector3, param4:TextureAnimation, param5:Number) : void {
      this.plane.init(param4,0.001 * param4.fps);
      this.maxTime = this.plane.getOneLoopTime();
      this.currentTime = 0;
      this.scaleSpeed = 0.001 * param5;
      this.baseScale = param1 / BASE_SIZE;
      this.scale = this.baseScale;
      this.plane.x = param2.x;
      this.plane.y = param2.y;
      this.plane.z = param2.z;
      this.plane.rotationX = param3.x;
      this.plane.rotationY = param3.y;
      this.plane.rotationZ = param3.z;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.plane);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.currentTime >= this.maxTime) {
        return false;
      }
      this.plane.setTime(this.currentTime);
      this.currentTime += param1;
      this.plane.scaleX = this.scale;
      this.plane.scaleY = this.scale;
      this.scale = this.baseScale + this.baseScale * this.scaleSpeed * this.currentTime;
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.plane);
      this.container = null;
      this.plane.clear();
      recycle();
    }

    public function kill() : void {
      this.currentTime = this.maxTime;
    }
  }
}
