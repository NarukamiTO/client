package controls {
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.utils.getTimer;

  [Embed(source="/_assets/assets.swf", symbol="symbol591")]
  public class SuicideIndicator extends Sprite {
    public var che:MovieClip;

    private var _che:MovieClip;
    private var endTime:int;
    private var nextTime:int;

    private const RATIO:int = 10;

    public function SuicideIndicator() {
      super();
      this._che = getChildByName("che") as MovieClip;
      visible = false;
    }

    public function show(param1:int) : void {
      var local2:int = getTimer();
      this.endTime = local2 + param1;
      this.nextTime = local2 + (this.endTime - local2) / this.RATIO;
      visible = true;
      this._che.visible = true;
      addEventListener(Event.ENTER_FRAME,this.triggerCherep);
    }

    private function triggerCherep(param1:Event) : void {
      var local2:int = getTimer();
      if(local2 >= this.nextTime) {
        this._che.visible = !this._che.visible;
        this.nextTime += (this.endTime - local2) / this.RATIO;
      }
      if(local2 >= this.endTime) {
        visible = false;
        removeEventListener(Event.ENTER_FRAME,this.triggerCherep);
      }
    }
  }
}
