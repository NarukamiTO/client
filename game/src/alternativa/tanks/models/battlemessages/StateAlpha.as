package alternativa.tanks.models.battlemessages {
  internal class StateAlpha implements MessageState {
    private var message:Message;
    private var transitionTime:int;
    private var timeLeft:int;
    private var alpha1:Number;
    private var alpha2:Number;
    private var deltaAlpha:Number;

    public function StateAlpha(param1:Message, param2:int, param3:Number, param4:Number) {
      super();
      this.message = param1;
      this.transitionTime = param2;
      this.alpha1 = param3;
      this.alpha2 = param4;
      this.deltaAlpha = param4 - param3;
    }

    public function init() : void {
      this.message.setAlpha(this.alpha1);
      this.timeLeft = this.transitionTime;
    }

    public function update(param1:int) : Boolean {
      if(this.timeLeft <= 0) {
        return false;
      }
      this.timeLeft -= param1;
      if(this.timeLeft < 0) {
        this.timeLeft = 0;
      }
      this.message.setAlpha(this.alpha2 - this.deltaAlpha * this.timeLeft / this.transitionTime);
      return true;
    }

    public function setDurationInMs(param1:int) : void {
      this.transitionTime = param1;
    }
  }
}
