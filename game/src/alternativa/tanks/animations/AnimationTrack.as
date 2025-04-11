package alternativa.tanks.animations {
  public class AnimationTrack {
    private var times:Vector.<Number>;
    private var values:Vector.<Number>;
    private var numFrames:int;
    private var minTime:Number;
    private var maxTime:Number;

    public function AnimationTrack(param1:Vector.<Number>, param2:Vector.<Number>) {
      super();
      this.times = param1;
      this.values = param2;
      this.numFrames = param1.length;
      this.minTime = param1[0];
      this.maxTime = param1[this.numFrames - 1];
    }

    public function getFrameTime(param1:int) : Number {
      return this.times[param1];
    }

    public function getNumFrames() : int {
      return this.numFrames;
    }

    public function getMinTime() : Number {
      return this.minTime;
    }

    public function getMaxTime() : Number {
      return this.maxTime;
    }

    public function getFrameValue(param1:int) : Number {
      return this.values[param1];
    }
  }
}
