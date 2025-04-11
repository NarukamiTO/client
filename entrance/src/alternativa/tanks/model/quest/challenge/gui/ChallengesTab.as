package alternativa.tanks.model.quest.challenge.gui {
  import alternativa.tanks.model.quest.challenge.ChallengeEvents;
  import alternativa.tanks.model.quest.challenge.ChallengesViewService;
  import alternativa.tanks.model.quest.common.MissionsWindowsService;
  import alternativa.tanks.model.quest.common.gui.window.QuestsTabView;
  import projects.tanks.client.panel.model.challenge.rewarding.Tier;

  public class ChallengesTab extends QuestsTabView implements ChallengesViewService {
    [Inject]
    public static var missionsWindowService:MissionsWindowsService;

    private var challengesView:ChallengesView;

    public function ChallengesTab() {
      super();
    }

    public function changeTiersInfo(param1:Vector.<Tier>) : void {
      this.getChallengesView().setTiersInfo(param1);
      if(missionsWindowService.isWindowOpen()) {
        this.getChallengesView().refreshTierListView();
      }
    }

    public function getTierNumber(param1:int) : int {
      return this.getChallengesView().getUserTierIndex(param1);
    }

    override public function show() : void {
      this.getChallengesView().initView();
      addChild(this.getChallengesView());
      dispatchEvent(new ChallengeEvents(ChallengeEvents.REQUEST_DATA));
    }

    private function getChallengesView() : ChallengesView {
      if(this.challengesView == null) {
        this.challengesView = new ChallengesView();
      }
      return this.challengesView;
    }

    override public function hide() : void {
      super.hide();
      removeChild(this.getChallengesView());
      this.getChallengesView().clear();
    }
  }
}
