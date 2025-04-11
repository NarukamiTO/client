package alternativa.tanks.battle {
  import flash.utils.getTimer;

  public class PerformanceMonitor {
    private var framesToAverage:int;
    private var minFrameTimeInMs:int;
    private var maxFrameTimeInMs:int;
    private var averageFrameTimeInMs:Number = 0;
    private var frameStartTime:int;
    private var frameCounter:int;
    private var cumulativeTimeInMs:int;

    public function PerformanceMonitor(param1:int) {
      super();
      this.framesToAverage = param1;
      this.reset();
    }

    public function beginFrame() : void {
      this.frameStartTime = getTimer();
    }

    public function endFrame() : void {
      var local1:int = getTimer() - this.frameStartTime;
      this.cumulativeTimeInMs += local1;
      this.updateMinMaxTime(local1);
      if(++this.frameCounter >= this.framesToAverage) {
        this.averageFrameTimeInMs = this.cumulativeTimeInMs / this.frameCounter;
        this.cumulativeTimeInMs = 0;
        this.frameCounter = 0;
      }
    }

    public function getAverageFrameTimeInMs() : Number {
      return this.averageFrameTimeInMs;
    }

    public function getAverageFps() : Number {
      return 1000 / this.averageFrameTimeInMs;
    }

    private function updateMinMaxTime(param1:int) : void {
      if(param1 > this.maxFrameTimeInMs) {
        this.maxFrameTimeInMs = param1;
      } else if(param1 < this.minFrameTimeInMs) {
        this.minFrameTimeInMs = param1;
      }
    }

    public function reset() : void {
      this.minFrameTimeInMs = 0;
      this.maxFrameTimeInMs = 0;
      this.averageFrameTimeInMs = 0;
      this.frameCounter = 0;
      this.cumulativeTimeInMs = 0;
    }
  }
}
