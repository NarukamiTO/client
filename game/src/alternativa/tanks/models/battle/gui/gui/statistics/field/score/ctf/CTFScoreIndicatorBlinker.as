package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf {
  public class CTFScoreIndicatorBlinker {
    public var values:Vector.<Number>;

    private var maxValue:Number;
    private var minValue:Number;
    private var intervals:Vector.<int>;
    private var speedCoeffs:Vector.<Number>;
    private var numValues:int;
    private var speeds:Vector.<Number>;
    private var switchTimes:Vector.<int>;
    private var valueDelta:Number;
    private var runCount:int = 0;

    public function CTFScoreIndicatorBlinker(param1:Number, param2:Number, param3:Vector.<int>, param4:Vector.<Number>) {
      super();
      this.minValue = param1;
      this.maxValue = param2;
      this.intervals = param3;
      this.speedCoeffs = param4;
      this.valueDelta = param2 - param1;
      this.numValues = param3.length;
      this.speeds = new Vector.<Number>(this.numValues);
      this.switchTimes = new Vector.<int>(this.numValues);
      this.values = new Vector.<Number>(this.numValues);
    }

    public function start(param1:int) : void {
      if(this.runCount == 0) {
        this.init(param1);
      }
      ++this.runCount;
    }

    public function stop() : void {
      --this.runCount;
    }

    public function update(param1:int, param2:int) : void {
      if(this.runCount <= 0) {
        return;
      }
      var local3:int = 0;
      while(local3 < this.numValues) {
        this.values[local3] += this.speeds[local3] * param2;
        if(this.values[local3] > this.maxValue) {
          this.values[local3] = this.maxValue;
        }
        if(this.values[local3] < this.minValue) {
          this.values[local3] = this.minValue;
        }
        if(param1 >= this.switchTimes[local3]) {
          this.switchTimes[local3] += this.intervals[local3];
          if(this.speeds[local3] < 0) {
            this.speeds[local3] = this.getSpeed(1,this.speedCoeffs[local3],this.intervals[local3]);
          } else {
            this.speeds[local3] = this.getSpeed(-1,this.speedCoeffs[local3],this.intervals[local3]);
          }
        }
        local3++;
      }
    }

    private function init(param1:int) : void {
      var local2:int = 0;
      while(local2 < this.numValues) {
        this.speeds[local2] = this.getSpeed(-1,this.speedCoeffs[local2],this.intervals[local2]);
        this.values[local2] = this.maxValue;
        this.switchTimes[local2] = param1 + this.intervals[local2];
        local2++;
      }
    }

    private function getSpeed(param1:Number, param2:Number, param3:int) : Number {
      return param1 * param2 * this.valueDelta / param3;
    }
  }
}
