package alternativa.tanks.models.battlemessages {
  internal class StateNormal implements MessageState {
    private var lifeTime:int;
    private var timeLeft:int;

    public function StateNormal(param1:int) {
      super();
      this.lifeTime = param1;
    }

    public function init() : void {
      this.timeLeft = this.lifeTime;
    }

    public function update(param1:int) : Boolean {
      if(this.timeLeft <= 0) {
        return false;
      }
      this.timeLeft -= param1;
      return true;
    }

    public function setDurationInMs(param1:int) : void {
      this.lifeTime = param1;
    }
  }
}
