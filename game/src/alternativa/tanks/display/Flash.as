package alternativa.tanks.display {
  import flash.utils.getTimer;

  public class Flash {
    private static const SHOW:int = 1;
    private static const FADE:int = 2;
    private static const DONE:int = 3;

    private var maxOffset:uint;
    private var flashDuration:int;
    private var fadeDuration:int;
    private var state:int = 3;
    private var startTime:int;

    public function Flash(param1:uint, param2:int, param3:int) {
      super();
      this.maxOffset = param1;
      this.flashDuration = param2;
      this.fadeDuration = param3;
    }

    public static function getDefault() : Flash {
      return new Flash(255,100,300);
    }

    public function isActive() : Boolean {
      return this.state != DONE;
    }

    public function init() : void {
      this.startTime = getTimer();
      this.state = SHOW;
    }

    public function getColorOffset(param1:int) : uint {
      var local2:uint = 0;
      switch(this.state) {
        case SHOW:
          if(param1 < this.startTime + this.flashDuration) {
            local2 = this.maxOffset * (param1 - this.startTime) / this.flashDuration;
          } else {
            local2 = this.maxOffset;
            this.startTime += this.flashDuration + this.fadeDuration;
            this.state = FADE;
          }
          break;
        case FADE:
          if(param1 < this.startTime) {
            local2 = this.maxOffset * (this.startTime - param1) / this.fadeDuration;
          } else {
            this.state = DONE;
            local2 = 0;
          }
      }
      return local2;
    }
  }
}
