package projects.tanks.clients.flash.commons.models.challenge {
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;

  public class ChallengesServiceImpl implements ChallengeInfoService {
    private var endTime:Number = 0;
    private var item:IGameObject = null;

    public function ChallengesServiceImpl() {
      super();
    }

    public function isInTime() : Boolean {
      return this.endTime > getTimer();
    }

    public function startEvent(param1:int) : void {
      this.endTime = param1 == 0 ? 0 : param1 * 1000 + getTimer();
    }

    public function getEndTime() : Number {
      return this.endTime;
    }
  }
}
