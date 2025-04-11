package alternativa.tanks.animations {
  public class KeyFrameAnimation {
    private var track:AnimationTrack;
    private var currentFrame:int;
    private var time:Number;
    private var animatedValue:AnimatedValue;

    public function KeyFrameAnimation(param1:AnimationTrack, param2:AnimatedValue) {
      super();
      this.track = param1;
      this.animatedValue = param2;
    }

    public function start() : void {
      this.time = this.track.getMinTime();
      this.currentFrame = 0;
    }

    public function isComplete() : Boolean {
      return this.currentFrame == this.track.getNumFrames() - 1;
    }

    public function update(param1:Number) : void {
      if(!this.isComplete()) {
        this.time += param1;
        while(this.time > this.track.getFrameTime(this.currentFrame + 1)) {
          ++this.currentFrame;
          if(this.isComplete()) {
            this.time = this.track.getMaxTime();
            break;
          }
        }
        this.animatedValue.setAnimatedValue(this.getValue());
      }
    }

    private function getValue() : Number {
      var local1:Number = NaN;
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local4:Number = NaN;
      if(this.isComplete()) {
        return this.track.getFrameTime(this.currentFrame);
      }
      local1 = this.track.getFrameTime(this.currentFrame);
      local2 = this.track.getFrameTime(this.currentFrame + 1);
      local3 = this.track.getFrameValue(this.currentFrame);
      local4 = this.track.getFrameValue(this.currentFrame + 1);
      return local3 + (local4 - local3) * (this.time - local1) / (local2 - local1);
    }
  }
}
