package alternativa.tanks.sfx {
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public final class AnimatedLightEffect extends PooledObject implements GraphicEffect {
    public static const DEFAULT_MAX_DISTANCE:Number = 99999;

    private var light:OmniLight;
    private var positionProvider:Object3DPositionProvider;
    private var animation:LightAnimation;
    private var currentTime:int;
    private var timeToLive:int;
    private var looped:Boolean;
    private var alive:Boolean;
    private var maxDistance:Number;
    private var fadeDistance:Number;
    private var position:Vector3 = new Vector3();
    private var container:Scene3DContainer;

    public function AnimatedLightEffect(param1:Pool) {
      super(param1);
      this.light = new OmniLight(0,0,0);
    }

    public function init(param1:Object3DPositionProvider, param2:LightAnimation, param3:Number = 99999, param4:Boolean = false) : void {
      this.initFromTime(param1,param2.getLiveTime(),param2,param3,param4);
    }

    public function initFromTime(param1:Object3DPositionProvider, param2:int, param3:LightAnimation, param4:Number = 99999, param5:Boolean = false) : void {
      this.positionProvider = param1;
      this.timeToLive = param2;
      this.currentTime = 0;
      this.animation = param3;
      this.looped = param5;
      this.alive = true;
      this.maxDistance = param4;
      this.fadeDistance = param4 / 4 * 3;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.light);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = NaN;
      var local4:Number = NaN;
      if(this.alive) {
        this.animation.updateByTime(this.light,this.currentTime,this.timeToLive);
        this.positionProvider.updateObjectPosition(this.light,param2,param1);
        this.currentTime += param1;
        if(this.currentTime > this.timeToLive) {
          if(this.looped) {
            this.currentTime %= this.timeToLive;
          } else {
            this.alive = false;
          }
        }
        this.position.x = this.light.x;
        this.position.y = this.light.y;
        this.position.z = this.light.z;
        local3 = Vector3.distanceBetween(this.position,param2.position);
        if(local3 > this.fadeDistance) {
          local4 = 1 - (local3 - this.fadeDistance) / (this.maxDistance - this.fadeDistance);
          this.light.intensity *= local4;
          this.light.visible = local3 < this.maxDistance;
        }
        return this.alive;
      }
      return false;
    }

    public function destroy() : void {
      this.container.removeChild(this.light);
      this.container = null;
      this.animation = null;
      this.positionProvider.destroy();
      this.positionProvider = null;
      recycle();
    }

    public function kill() : void {
      this.alive = false;
    }
  }
}
