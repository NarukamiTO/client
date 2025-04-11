package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Light3D;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class StreamLightEffect extends PooledObject implements GraphicEffect {
    private static const FADE_TIME:int = 250;

    protected var light:Light3D;
    protected var startAnimation:LightAnimation;
    protected var loopAnimation:LightAnimation;
    protected var startTime:int;
    protected var loopTime:int;
    protected var currentLoopTime:int;
    protected var currentTime:int;
    protected var starting:Boolean;
    protected var positionProvider:Object3DPositionProvider;
    protected var alive:Boolean;
    protected var random:int;
    protected var fading:Boolean;
    protected var fadeTime:int;
    protected var container:Scene3DContainer;

    public function StreamLightEffect(param1:Pool, param2:Light3D) {
      super(param1);
      this.light = param2;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.light);
    }

    private function startLoop() : void {
      this.currentLoopTime = this.loopTime + (Math.random() * this.random - this.random / 2);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(!this.alive) {
        return false;
      }
      if(this.starting) {
        this.currentTime += param1;
        this.startAnimation.updateByTime(this.light,this.currentTime,this.startTime);
        if(this.currentTime >= this.startTime) {
          this.starting = false;
          this.currentTime = 0;
          this.startLoop();
        }
      } else {
        this.currentTime += param1;
        if(this.currentTime > this.currentLoopTime) {
          this.currentTime %= this.currentLoopTime;
          this.startLoop();
        }
        this.loopAnimation.updateByTime(this.light,this.currentTime,this.loopTime);
      }
      this.positionProvider.updateObjectPosition(this.light,param2,param1);
      if(this.fading) {
        this.fadeTime += param1;
        if(this.fadeTime <= FADE_TIME) {
          this.light.intensity *= 1 - this.fadeTime / FADE_TIME;
        } else {
          this.light.intensity = 0;
          this.kill();
        }
      }
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.light);
      this.container = null;
      this.startAnimation = null;
      this.loopAnimation = null;
      this.positionProvider.destroy();
      this.positionProvider = null;
      recycle();
    }

    public function kill() : void {
      this.alive = false;
    }

    public function stop() : void {
      this.fading = true;
      this.fadeTime = 0;
    }
  }
}
