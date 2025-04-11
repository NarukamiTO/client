package alternativa.tanks.model.quest.challenge.rewarding {
  import alternativa.tanks.model.challenge.battlepass.notifier.BattlePassPurchaseEvent;
  import alternativa.tanks.model.challenge.battlepass.notifier.BattlePassPurchaseService;
  import alternativa.tanks.model.quest.challenge.ChallengeEvents;
  import alternativa.tanks.model.quest.challenge.ChallengesViewService;
  import alternativa.tanks.model.quest.challenge.stars.StarsChangedEvent;
  import alternativa.tanks.model.quest.challenge.stars.StarsInfoService;
  import alternativa.tanks.model.quest.common.MissionsWindowsService;
  import flash.events.Event;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.challenge.rewarding.ChallengesRewardingModelBase;
  import projects.tanks.client.panel.model.challenge.rewarding.IChallengesRewardingModelBase;
  import projects.tanks.client.panel.model.challenge.rewarding.Tier;

  [ModelInfo]
  public class ChallengesRewardingModel extends ChallengesRewardingModelBase implements IChallengesRewardingModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var challengeService:ChallengesViewService;

    [Inject]
    public static var starsInfoService:StarsInfoService;

    [Inject]
    public static var missionsWindowService:MissionsWindowsService;

    [Inject]
    public static var battlePassPurchaseService:BattlePassPurchaseService;

    public function ChallengesRewardingModel() {
      super();
    }

    public function objectLoaded() : void {
      challengeService.changeTiersInfo(getInitParam().tiers);
      challengeService.addEventListener(ChallengeEvents.REQUEST_DATA,getFunctionWrapper(this.requestTiersInfo));
      var local1:Function = getFunctionWrapper(this.conditionRequestTiersInfo);
      battlePassPurchaseService.addEventListener(BattlePassPurchaseEvent.PURCHASE,local1);
      starsInfoService.addEventListener(StarsChangedEvent.STARS_CHANGED,local1);
    }

    private function requestTiersInfo(param1:Event = null) : void {
      server.requestTiersInfo();
    }

    private function conditionRequestTiersInfo(param1:Event) : void {
      if(missionsWindowService.isWindowOpen()) {
        this.requestTiersInfo();
      }
    }

    public function sendTiersInfo(param1:Vector.<Tier>) : void {
      challengeService.changeTiersInfo(param1);
    }

    public function objectUnloaded() : void {
      challengeService.removeEventListener(ChallengeEvents.REQUEST_DATA,getFunctionWrapper(this.requestTiersInfo));
      var local1:Function = getFunctionWrapper(this.conditionRequestTiersInfo);
      battlePassPurchaseService.removeEventListener(BattlePassPurchaseEvent.PURCHASE,local1);
      starsInfoService.removeEventListener(StarsChangedEvent.STARS_CHANGED,local1);
      missionsWindowService.closeWindow();
    }
  }
}
