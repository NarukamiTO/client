package alternativa.tanks.gui.effects {
  import alternativa.tanks.service.fps.FPSService;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.filters.GlowFilter;

  public class GlowEffect extends EventDispatcher {
    [Inject]
    public static var fpsService:FPSService;

    private static const EFFECT_TIME:Number = 1.25;

    private var glowAlpha:Number;
    private var glowColor:int;
    private var glowDelta:Number;

    public function GlowEffect() {
      super();
    }

    public static function glow(param1:DisplayObject, param2:uint) : void {
      var local3:GlowEffect = new GlowEffect();
      local3.glow(param1,param2);
    }

    public function glow(param1:DisplayObject, param2:uint) : void {
      this.glowAlpha = param1.alpha;
      this.glowColor = param2;
      this.glowDelta = 1 / (EFFECT_TIME * fpsService.getFps());
      param1.addEventListener(Event.ENTER_FRAME,this.glowFrame);
    }

    private function glowFrame(param1:Event) : void {
      var local2:DisplayObject = param1.target as DisplayObject;
      var local3:GlowFilter = new GlowFilter(this.glowColor,this.glowAlpha,6,6,4,1,false);
      local2.filters = [local3];
      this.glowAlpha -= this.glowDelta;
      if(this.glowAlpha < 0) {
        local2.filters = [];
        local2.removeEventListener(Event.ENTER_FRAME,this.glowFrame);
        dispatchEvent(new Event(Event.COMPLETE));
      }
    }
  }
}
