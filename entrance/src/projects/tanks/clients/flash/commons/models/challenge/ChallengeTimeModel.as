package projects.tanks.clients.flash.commons.models.challenge {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.commons.models.challenge.time.ChallengesTimeModelBase;
  import projects.tanks.client.commons.models.challenge.time.IChallengesTimeModelBase;

  [ModelInfo]
  public class ChallengeTimeModel extends ChallengesTimeModelBase implements IChallengesTimeModelBase, ObjectLoadListener {
    [Inject]
    public static var challengesService:ChallengeInfoService;

    public function ChallengeTimeModel() {
      super();
    }

    public function objectLoaded() : void {
      challengesService.startEvent(getInitParam().timeLeftSec);
    }
  }
}
