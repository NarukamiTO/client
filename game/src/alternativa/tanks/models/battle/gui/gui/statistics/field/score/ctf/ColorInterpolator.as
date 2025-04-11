package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf {
  public class ColorInterpolator {
    public var startColor:uint;

    private var deltaRed:Number;
    private var deltaGreen:Number;
    private var deltaBlue:Number;

    public function ColorInterpolator(param1:uint, param2:uint) {
      super();
      this.startColor = param1;
      this.deltaRed = (param2 >> 16 & 0xFF) - (param1 >> 16 & 0xFF);
      this.deltaGreen = (param2 >> 8 & 0xFF) - (param1 >> 8 & 0xFF);
      this.deltaBlue = (param2 & 0xFF) - (param1 & 0xFF);
    }

    public function interpolate(param1:Number) : uint {
      var local2:int = (this.startColor >> 16 & 0xFF) + param1 * this.deltaRed;
      var local3:int = (this.startColor >> 8 & 0xFF) + param1 * this.deltaGreen;
      var local4:int = (this.startColor & 0xFF) + param1 * this.deltaBlue;
      return local2 << 16 | local3 << 8 | local4;
    }
  }
}
