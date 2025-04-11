package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.CTFScoreIndicatorBlinker;
  import flash.utils.getTimer;

  public class StateLost implements IFlagIndicatorState {
    private var type:int;
    private var indicator:FlagIndicator;
    private var blinker:CTFScoreIndicatorBlinker;
    private var valueIndex:int;

    public function StateLost(param1:int, param2:FlagIndicator, param3:CTFScoreIndicatorBlinker, param4:int) {
      super();
      this.type = param1;
      this.indicator = param2;
      this.blinker = param3;
      this.valueIndex = param4;
    }

    public function getType() : int {
      return this.type;
    }

    public function start() : void {
      this.blinker.start(getTimer());
      this.indicator.normalBitmap.visible = true;
      this.indicator.normalBitmap.alpha = 1;
      this.indicator.flashBitmap.visible = false;
      this.indicator.lostBitmap.visible = true;
      this.indicator.lostBitmap.alpha = 0;
    }

    public function stop() : void {
      this.blinker.stop();
    }

    public function update(param1:int, param2:int) : void {
      var local3:Number = this.blinker.values[this.valueIndex];
      this.indicator.normalBitmap.alpha = local3;
      this.indicator.lostBitmap.alpha = 1 - local3;
    }
  }
}
