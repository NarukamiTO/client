package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.CTFScoreIndicatorBlinker;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.utils.Dictionary;

  public class FlagIndicator extends Sprite {
    public static const STATE_DEFAULT:int = 1;
    public static const STATE_BLINK:int = 2;
    public static const STATE_EMPTY:int = 3;
    public static const STATE_FLASHING:int = 4;

    public var normalBitmap:Bitmap;
    public var lostBitmap:Bitmap;
    public var flashBitmap:Bitmap;

    private var states:Dictionary = new Dictionary();
    private var currentState:IFlagIndicatorState;

    public function FlagIndicator(param1:Bitmap, param2:Bitmap, param3:Bitmap, param4:CTFScoreIndicatorBlinker) {
      super();
      this.normalBitmap = param1;
      this.lostBitmap = param2;
      this.flashBitmap = param3;
      addChild(param1);
      addChild(param2);
      addChild(param3);
      this.states[STATE_DEFAULT] = new StateAtBase(STATE_DEFAULT,this);
      this.states[STATE_FLASHING] = new StateFlash(STATE_FLASHING,this,10 / 1000,1 / 1000,300);
      this.states[STATE_BLINK] = new StateLost(STATE_BLINK,this,param4,0);
      this.states[STATE_EMPTY] = new StateLost(STATE_EMPTY,this,param4,1);
      this.currentState = this.states[STATE_DEFAULT];
      this.currentState.start();
    }

    public function setState(param1:int) : void {
      if(this.currentState.getType() == param1) {
        return;
      }
      this.currentState.stop();
      this.currentState = this.states[param1];
      this.currentState.start();
    }

    public function update(param1:int, param2:int) : void {
      this.currentState.update(param1,param2);
    }
  }
}
