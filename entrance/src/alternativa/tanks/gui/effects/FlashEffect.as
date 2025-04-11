package alternativa.tanks.gui.effects {
  import alternativa.tanks.service.fps.FPSService;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.geom.ColorTransform;

  public class FlashEffect extends EventDispatcher {
    [Inject]
    public static var fpsService:FPSService;

    private static const EFFECT_TIME:Number = 1.25;

    private var numFrames:int;
    private var A:Number;
    private var frame:int;
    private var target:DisplayObject;

    public function FlashEffect() {
      super();
    }

    public static function flash(param1:DisplayObject) : void {
      var local2:FlashEffect = new FlashEffect();
      local2.flash(param1);
    }

    public function flash(param1:DisplayObject) : void {
      this.numFrames = Math.ceil(fpsService.getFps() * EFFECT_TIME);
      this.A = 4 / (this.numFrames * this.numFrames);
      this.target = param1;
      param1.addEventListener(Event.ENTER_FRAME,this.onFrame);
      this.frame = 0;
    }

    private function onFrame(param1:Event) : void {
      ++this.frame;
      if(this.frame == this.numFrames) {
        this.stop();
        dispatchEvent(new Event(Event.COMPLETE));
        return;
      }
      var local2:Number = 1 - this.A * (this.frame * (this.frame - this.numFrames));
      this.setTransform(this.target,local2);
    }

    public function stop() : void {
      if(this.target != null) {
        this.setTransform(this.target,1);
        this.target.removeEventListener(Event.ENTER_FRAME,this.onFrame);
        this.target = null;
      }
    }

    private function setTransform(param1:DisplayObject, param2:Number) : void {
      param1.transform.colorTransform = new ColorTransform(param2,param2,param2);
    }
  }
}
