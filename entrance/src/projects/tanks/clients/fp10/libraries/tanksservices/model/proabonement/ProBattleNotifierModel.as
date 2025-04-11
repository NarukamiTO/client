package projects.tanks.clients.fp10.libraries.tanksservices.model.proabonement {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.tanksservices.model.proabonementnotifier.IProBattleNotifierModelBase;
  import projects.tanks.client.tanksservices.model.proabonementnotifier.ProBattleNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;

  [ModelInfo]
  public class ProBattleNotifierModel extends ProBattleNotifierModelBase implements IProBattleNotifierModelBase, ObjectLoadListener {
    [Inject]
    public static var userProBattleService:IUserProBattleService;

    public function ProBattleNotifierModel() {
      super();
    }

    public function objectLoaded() : void {
      userProBattleService.setAbonementRemainingTimeSec(getInitParam().abonementRemainingTimeInSec);
    }

    public function setRemainingAbonementTimeSec(param1:int) : void {
      userProBattleService.setAbonementRemainingTimeSec(param1);
    }
  }
}
