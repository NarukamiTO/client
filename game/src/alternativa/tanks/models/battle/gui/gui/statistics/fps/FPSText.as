package alternativa.tanks.models.battle.gui.gui.statistics.fps {
  import alternativa.tanks.services.performance.PerformanceDataService;
  import alternativa.tanks.services.ping.PingService;
  import controls.Label;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.filters.GlowFilter;
  import flash.text.TextFieldAutoSize;
  import flash.utils.getTimer;

  public class FPSText extends Sprite {
    [Inject]
    public static var pingService:PingService;

    [Inject]
    public static var performanceDataService:PerformanceDataService;

    private static const MAX_FPS:int = 60;
    private static const MIN_PING:int = 0;
    private static const MAX_PING:int = 999;
    private static const DELTA_LINE:int = 19;
    private static const OFFSET_X:int = 50 + 8;
    private static const OFFSET_Y:int = 74 + DELTA_LINE;
    private static const VALUE_OFFSET_X:int = 40 + 8;
    private static const NUM_FRAMES:int = 10;
    private static const glowFilter:GlowFilter = new GlowFilter(0,0.8,4,4,3);

    private var fpsLabel:Label;
    private var fpsValue:Label;
    private var pingLabel:Label;
    private var pingValue:Label;
    private var counter:int;
    private var time:int;
    private var inited:Boolean = false;

    public function FPSText() {
      super();
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    private function init() : void {
      if(!this.inited) {
        this.fpsLabel = new Label();
        this.fpsLabel.autoSize = TextFieldAutoSize.LEFT;
        this.fpsLabel.color = 16777215;
        this.fpsLabel.text = "FPS: ";
        this.fpsLabel.selectable = false;
        addChild(this.fpsLabel);
        this.fpsValue = new Label();
        this.fpsValue.autoSize = TextFieldAutoSize.LEFT;
        this.fpsValue.color = int(performanceDataService.getIndicatorHighFPSColor());
        this.fpsValue.text = MAX_FPS.toString();
        this.fpsValue.selectable = false;
        addChild(this.fpsValue);
        this.pingLabel = new Label();
        this.pingLabel.autoSize = TextFieldAutoSize.LEFT;
        this.pingLabel.color = 16777215;
        this.pingLabel.text = "PING: ";
        this.pingLabel.selectable = false;
        this.pingLabel.x = -7;
        this.pingLabel.y = DELTA_LINE;
        addChild(this.pingLabel);
        this.pingValue = new Label();
        this.pingValue.autoSize = TextFieldAutoSize.LEFT;
        this.pingValue.color = int(performanceDataService.getIndicatorLowPingColor());
        this.pingValue.text = MIN_PING.toString();
        this.pingValue.selectable = false;
        this.pingValue.y = DELTA_LINE;
        addChild(this.pingValue);
        filters = [glowFilter];
        this.inited = true;
      }
    }

    private function onAddedToStage(param1:Event) : void {
      this.init();
      this.onResize();
      this.counter = 0;
      this.time = getTimer();
      stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      stage.addEventListener(Event.RESIZE,this.onResize);
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
    }

    private function onRemovedFromStage(param1:Event) : void {
      stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      stage.removeEventListener(Event.RESIZE,this.onResize);
      removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    private function onEnterFrame(param1:Event) : void {
      var local2:int = 0;
      var local3:Number = NaN;
      var local4:Number = NaN;
      if(++this.counter >= NUM_FRAMES) {
        local2 = getTimer();
        local3 = 1000 * this.counter / (local2 - this.time);
        if(local3 > MAX_FPS) {
          local3 = MAX_FPS;
        }
        this.fpsValue.text = Math.round(local3).toString();
        this.fpsValue.x = VALUE_OFFSET_X - this.fpsValue.width;
        if(local3 > performanceDataService.getIndicatorLowFPS()) {
          if(local3 < performanceDataService.getIndicatorHighFPS()) {
            this.fpsValue.color = this.interpolateColor(int(performanceDataService.getIndicatorLowFPSColor()),int(performanceDataService.getIndicatorHighFPSColor()),(local3 - performanceDataService.getIndicatorLowFPS()) / (performanceDataService.getIndicatorHighFPS() - performanceDataService.getIndicatorLowFPS()));
          } else {
            this.fpsValue.color = int(performanceDataService.getIndicatorHighFPSColor());
          }
        } else if(local3 > performanceDataService.getIndicatorVeryLowFPS()) {
          this.fpsValue.color = this.interpolateColor(int(performanceDataService.getIndicatorVeryLowFPSColor()),int(performanceDataService.getIndicatorLowFPSColor()),(local3 - performanceDataService.getIndicatorVeryLowFPS()) / (performanceDataService.getIndicatorLowFPS() - performanceDataService.getIndicatorVeryLowFPS()));
        } else {
          this.fpsValue.color = int(performanceDataService.getIndicatorVeryLowFPSColor());
        }
        this.time = local2;
        this.counter = 0;
        local4 = Number(pingService.getPing());
        if(local4 > MAX_PING) {
          local4 = MAX_PING;
        }
        this.pingValue.text = Math.round(local4).toString();
        this.pingValue.x = VALUE_OFFSET_X - this.pingValue.width;
        if(local4 < performanceDataService.getIndicatorHighPing()) {
          if(local4 > performanceDataService.getIndicatorLowPing()) {
            this.pingValue.color = this.interpolateColor(int(performanceDataService.getIndicatorLowPingColor()),int(performanceDataService.getIndicatorHighPingColor()),(local4 - performanceDataService.getIndicatorLowPing()) / (performanceDataService.getIndicatorHighPing() - performanceDataService.getIndicatorLowPing()));
          } else {
            this.pingValue.color = int(performanceDataService.getIndicatorLowPingColor());
          }
        } else if(local4 < performanceDataService.getIndicatorVeryHighPing()) {
          this.pingValue.color = this.interpolateColor(int(performanceDataService.getIndicatorHighPingColor()),int(performanceDataService.getIndicatorVeryHighPingColor()),(local4 - performanceDataService.getIndicatorHighPing()) / (performanceDataService.getIndicatorVeryHighPing() - performanceDataService.getIndicatorHighPing()));
        } else {
          this.pingValue.color = int(performanceDataService.getIndicatorVeryHighPingColor());
        }
      }
    }

    private function interpolateColor(param1:int, param2:int, param3:Number) : int {
      var local4:int = param1 >> 16 & 0xFF;
      var local5:int = param1 >> 8 & 0xFF;
      var local6:int = param1 & 0xFF;
      var local7:int = param2 >> 16 & 0xFF;
      var local8:int = param2 >> 8 & 0xFF;
      var local9:int = param2 & 0xFF;
      if(param3 > 1) {
        param3 = 1;
      }
      return local4 + (local7 - local4) * param3 << 16 | local5 + (local8 - local5) * param3 << 8 | int(local6 + (local9 - local6) * param3);
    }

    private function onResize(param1:Event = null) : void {
      x = stage.stageWidth - OFFSET_X;
      y = stage.stageHeight - OFFSET_Y;
      this.fpsValue.x = VALUE_OFFSET_X - this.fpsValue.width;
      this.pingValue.x = VALUE_OFFSET_X - this.pingValue.width;
    }
  }
}
