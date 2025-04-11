package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.lights.TubeLight;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class TubeLightEffect extends PooledObject implements GraphicEffect {
    private static const CAMERA_DISTANCE_COEF:Number = 1.5;
    private static const position:Vector3 = new Vector3();
    private static const targetPositon:Vector3 = new Vector3();

    private var light:TubeLight;
    private var positionProvider:Object3DPositionProvider;
    private var targetProvider:Object3DPositionProvider;
    private var animation:LightAnimation;
    private var currentTime:int;
    private var timeToLive:int;
    private var looped:Boolean;
    private var alive:Boolean;
    private var target:Object3D;
    private var container:Scene3DContainer;

    public function TubeLightEffect(param1:Pool) {
      super(param1);
      this.light = new TubeLight(0,0,0,0,0);
      this.target = new Object3D();
    }

    public function init(param1:Object3DPositionProvider, param2:Object3DPositionProvider, param3:LightAnimation, param4:Boolean = false) : void {
      this.initFromTime(param1,param2,param3.getLiveTime(),param3,param4);
    }

    public function initFromTime(param1:Object3DPositionProvider, param2:Object3DPositionProvider, param3:int, param4:LightAnimation, param5:Boolean = false) : void {
      this.positionProvider = param1;
      this.targetProvider = param2;
      this.timeToLive = param3;
      this.currentTime = 0;
      this.animation = param4;
      this.looped = param5;
      this.alive = true;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.light);
      param1.addChild(this.target);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = NaN;
      var local4:Number = NaN;
      if(this.alive) {
        this.animation.updateByTime(this.light,this.currentTime,this.timeToLive);
        this.positionProvider.updateObjectPosition(this.light,param2,param1);
        this.targetProvider.updateObjectPosition(this.target,param2,param1);
        this.currentTime += param1;
        position.x = this.light.x;
        position.y = this.light.y;
        position.z = this.light.z;
        targetPositon.x = this.target.x;
        targetPositon.y = this.target.y;
        targetPositon.z = this.target.z;
        local3 = Vector3.distanceBetween(position,targetPositon);
        local4 = param2.farClipping / CAMERA_DISTANCE_COEF;
        local3 = local3 > local4 ? local4 : local3;
        this.light.length = local3;
        if(this.currentTime > this.timeToLive) {
          if(this.looped) {
            this.currentTime %= this.timeToLive;
          } else {
            this.alive = false;
          }
        }
        this.light.lookAt(this.target.x,this.target.y,this.target.z);
        this.light.falloff = this.light.attenuationEnd - this.light.attenuationBegin;
        return this.alive;
      }
      return false;
    }

    public function destroy() : void {
      this.container.removeChild(this.light);
      this.container.removeChild(this.target);
      this.container = null;
      this.animation = null;
      this.positionProvider = null;
      recycle();
    }

    public function kill() : void {
      this.alive = false;
    }
  }
}
