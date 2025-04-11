package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator {
  public class StateAtBase implements IFlagIndicatorState {
    private var type:int;
    private var indicator:FlagIndicator;

    public function StateAtBase(param1:int, param2:FlagIndicator) {
      super();
      this.type = param1;
      this.indicator = param2;
    }

    public function getType() : int {
      return this.type;
    }

    public function start() : void {
      this.indicator.normalBitmap.visible = true;
      this.indicator.normalBitmap.alpha = 1;
      this.indicator.flashBitmap.visible = false;
      this.indicator.lostBitmap.visible = false;
    }

    public function stop() : void {
    }

    public function update(param1:int, param2:int) : void {
    }
  }
}
