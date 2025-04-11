package alternativa.tanks.models.battle.battlefield {
  import flash.utils.getTimer;

  internal class TimeStatistics {
    private static const FRAMES_TO_AVERAGE:int = 10;

    private var _averageTimeInMs:Number;
    private var _fps:Number;
    private var _minFPS:Number;
    private var _maxFPS:Number;
    private var _totalFrames:int;
    private var accumulatedFrames:int;
    private var startTimeInMs:int;
    private var lastCalculationTimeInMs:int;

    public function TimeStatistics() {
      super();
      this.reset();
    }

    public function get averageTimeInMs() : Number {
      return this._averageTimeInMs;
    }

    public function get fps() : Number {
      return this._fps;
    }

    public function get minFPS() : Number {
      return this._minFPS;
    }

    public function get maxFPS() : Number {
      return this._maxFPS;
    }

    public function getAverageFPS() : Number {
      return 1000 / (this.lastCalculationTimeInMs - this.startTimeInMs) * this._totalFrames;
    }

    public function get totalFrames() : int {
      return this._totalFrames;
    }

    public function get totalTime() : int {
      return this.lastCalculationTimeInMs - this.startTimeInMs;
    }

    public function reset() : void {
      this.accumulatedFrames = 0;
      this._averageTimeInMs = 0;
      this._fps = 100;
      this._minFPS = 100;
      this._maxFPS = 0;
      this._totalFrames = 0;
      this.startTimeInMs = getTimer();
      this.lastCalculationTimeInMs = this.startTimeInMs;
    }

    public function update() : void {
      var local1:int = getTimer();
      this.increaseFrameCounters();
      if(this.shoudCalculateAverageValues(local1)) {
        this.calculateAverageValues(local1);
        this.updateMinMaxFPSValues();
        this.lastCalculationTimeInMs = local1;
      }
    }

    private function increaseFrameCounters() : void {
      ++this._totalFrames;
      ++this.accumulatedFrames;
    }

    private function shoudCalculateAverageValues(param1:int) : Boolean {
      return this.accumulatedFrames >= FRAMES_TO_AVERAGE && param1 > this.lastCalculationTimeInMs;
    }

    private function calculateAverageValues(param1:int) : void {
      this._averageTimeInMs = (param1 - this.lastCalculationTimeInMs) / this.accumulatedFrames;
      this._fps = 1000 / this._averageTimeInMs;
      this.accumulatedFrames = 0;
    }

    private function updateMinMaxFPSValues() : void {
      this._minFPS = Math.min(this._minFPS,this._fps);
      this._maxFPS = Math.max(this._maxFPS,this._fps);
    }
  }
}
