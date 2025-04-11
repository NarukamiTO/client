package alternativa.tanks.models.tank {
  import flash.utils.getTimer;

  public class IdleKickTime {
    private var kickTime:uint;

    public function IdleKickTime() {
      super();
    }

    public function reset(param1:uint) : void {
      this.kickTime = getTimer() + param1;
    }

    public function getTimeLeft() : uint {
      return this.kickTime - getTimer();
    }
  }
}
