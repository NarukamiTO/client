package alternativa.tanks.gui.clanmanagement.clanmemberlist.candidates {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.ClanUserItem;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.DeleteIndicator;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.tanks.service.clan.ClanMembersListEvent;
  import alternativa.types.Long;
  import flash.events.Event;
  import flash.events.MouseEvent;

  public class ClanOutgoingRequestsItem extends ClanUserItem {
    [Inject]
    public static var clanService:ClanService;

    public function ClanOutgoingRequestsItem(param1:Long) {
      super();
      userContainer = createUserLabel(param1);
      addChild(userContainer);
      _deleteIndicator = new DeleteIndicator(false);
      addChild(_deleteIndicator);
      _deleteIndicator.visible = false;
      _deleteIndicator.addEventListener(MouseEvent.CLICK,this.onClickDelete,false,0,true);
      this.onResize();
    }

    private function onClickDelete(param1:MouseEvent) : void {
      dispatchEvent(new ClanMembersListEvent(ClanMembersListEvent.REVOKE_USER,_userLabel.userId,_userLabel.uid,true,true));
    }

    override protected function onResize(param1:Event = null) : void {
      userContainer.x = MARGIN;
      userContainer.y = 1;
      userContainer.width = width - 2 * MARGIN;
      _deleteIndicator.x = width - _deleteIndicator.width - 6;
      _deleteIndicator.y = 1;
      redrawBackground();
    }
  }
}
