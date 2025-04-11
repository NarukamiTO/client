package alternativa.tanks.battle {
  import flash.utils.getTimer;

  public class FPSCounter {
    private var framesToAverage:int;
    private var lastTime:int;
    private var frameCounter:int;
    private var fps:Number = 0;

    public function FPSCounter(param1:int) {
      super();
      this.framesToAverage = param1;
      this.lastTime = getTimer();
    }

    public function update() : void {
      var local1:int = 0;
      var local2:int = 0;
      if(++this.frameCounter >= this.framesToAverage) {
        local1 = getTimer();
        local2 = local1 - this.lastTime;
        this.lastTime = local1;
        this.fps = 1000 * this.frameCounter / local2;
        this.frameCounter = 0;
      }
    }

    public function getFPS() : Number {
      return this.fps;
    }
  }
}
