package alternativa.tanks.service.fps {
  import alternativa.osgi.service.display.IDisplay;
  import flash.events.Event;
  import flash.utils.getTimer;

  public class FPSServiceImpl implements FPSService {
    [Inject]
    public static var dispay:IDisplay;

    private var fps:Number;
    private var frameTime:Number;
    private var lastTime:int;
    private var numFrames:int;
    private var deactiave:Boolean;
    private var starting:Boolean;

    public function FPSServiceImpl() {
      super();
    }

    public function start() : void {
      this.setFps(dispay.stage.frameRate);
      dispay.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      dispay.stage.addEventListener(Event.DEACTIVATE,this.onDeactivate);
      this.deactiave = false;
      this.starting = true;
    }

    private function onActivate(param1:Event) : void {
      if(param1.target == dispay.stage) {
        dispay.stage.removeEventListener(Event.ACTIVATE,this.onActivate);
        this.deactiave = false;
        this.starting = true;
      }
    }

    private function onDeactivate(param1:Event) : void {
      if(param1.target == dispay.stage) {
        dispay.stage.addEventListener(Event.ACTIVATE,this.onActivate);
        this.deactiave = true;
      }
    }

    private function onEnterFrame(param1:Event) : void {
      if(this.deactiave) {
        return;
      }
      if(this.starting) {
        this.lastTime = getTimer();
        this.numFrames = 0;
        this.starting = false;
        return;
      }
      var local2:int = getTimer();
      ++this.numFrames;
      if(local2 - this.lastTime > 2000) {
        this.setFps(1000 * this.numFrames / (local2 - this.lastTime));
        this.lastTime = local2;
        this.numFrames = 0;
      }
    }

    private function setFps(param1:Number) : void {
      this.fps = param1;
      this.frameTime = 1000 / param1;
    }

    public function getFps() : Number {
      return this.fps;
    }

    public function getFrameTimeMS() : Number {
      return this.frameTime;
    }
  }
}
