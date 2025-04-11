package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.PerformanceMonitor;
  import flash.display.DisplayObjectContainer;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;

  public class PerformanceDisplay implements LogicUnit {
    private var performanceMonitor:PerformanceMonitor;
    private var tf:TextField;

    public function PerformanceDisplay(param1:PerformanceMonitor, param2:DisplayObjectContainer) {
      super();
      this.performanceMonitor = param1;
      this.tf = new TextField();
      this.tf.defaultTextFormat = new TextFormat("Tahoma",16,16777215);
      this.tf.autoSize = TextFieldAutoSize.LEFT;
      param2.addChild(this.tf);
    }

    public function runLogic(param1:int, param2:int) : void {
      this.tf.text = this.performanceMonitor.getAverageFrameTimeInMs().toFixed(3);
    }
  }
}
