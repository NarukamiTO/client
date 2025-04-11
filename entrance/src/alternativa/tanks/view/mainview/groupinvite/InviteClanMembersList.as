package alternativa.tanks.view.mainview.groupinvite {
  import alternativa.types.Long;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.LeaveBattleNotifierServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.SetBattleNotifierServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.OnlineNotifierServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class InviteClanMembersList extends InviteToGroupList {
    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    public function InviteClanMembersList() {
      super();
    }

    override public function init() : void {
      list.addEventListener(InviteUserEvent.TYPE,onInviteUser);
      onlineNotifierService.addEventListener(OnlineNotifierServiceEvent.SET_ONLINE,onSetOnline);
      battleNotifierService.addEventListener(SetBattleNotifierServiceEvent.SET_BATTLE,onSetBattle);
      battleNotifierService.addEventListener(LeaveBattleNotifierServiceEvent.LEAVE,onLeaveBattle);
    }

    override public function fillList(param1:Vector.<Long>) : void {
      var local2:Long = null;
      dataProvider.removeAll();
      dataProvider.resetFilter(false);
      for each(local2 in param1) {
        dataProvider.addUser(local2,false);
      }
      dataProvider.refresh();
    }
  }
}
