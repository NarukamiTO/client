package alternativa.tanks.gui.effects {
  import alternativa.tanks.service.fps.FPSService;
  import flash.display.DisplayObject;
  import flash.events.Event;

  public class BlinkEffect {
    [Inject]
    public static var fpsService:FPSService;

    private var state:int;
    private var displayObject:DisplayObject;
    private var peakFramesCoeff:Number = 0.15;
    private var betweenPeaksFramesCoeff:Number = 0.3;

    public function BlinkEffect(param1:Number = 0.15, param2:Number = 0.3) {
      super();
      this.peakFramesCoeff = param1;
      this.betweenPeaksFramesCoeff = param2;
    }

    public function start(param1:DisplayObject) : void {
      this.stop();
      this.displayObject = param1;
      this.state = 0;
      param1.alpha = 1;
      param1.addEventListener(Event.ENTER_FRAME,this.onFrame);
    }

    public function stop() : void {
      if(this.displayObject != null) {
        this.displayObject.removeEventListener(Event.ENTER_FRAME,this.onFrame);
        this.displayObject.alpha = 1;
        this.displayObject = null;
      }
    }

    private function onFrame(param1:Event) : void {
      var local2:int = 0;
      var local3:int = 0;
      local2 = Math.ceil(this.peakFramesCoeff * fpsService.getFps());
      local3 = Math.ceil(this.betweenPeaksFramesCoeff * fpsService.getFps());
      ++this.state;
      if(this.state < local2) {
        this.displayObject.alpha = 1;
      } else if(this.state < local2 + local3) {
        this.displayObject.alpha = 1 - (this.state - local2) / local3;
      } else if(this.state < local2 + local3 + local2) {
        this.displayObject.alpha = 0;
      } else if(this.state < local2 + local3 + local2 + local3) {
        this.displayObject.alpha = (this.state - local2 - local3 - local2) / local3;
      } else {
        this.displayObject.alpha = 1;
        this.state = 0;
      }
    }
  }
}
