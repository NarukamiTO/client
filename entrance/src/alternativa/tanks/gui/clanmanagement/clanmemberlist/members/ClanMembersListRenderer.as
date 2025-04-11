package alternativa.tanks.gui.clanmanagement.clanmemberlist.members {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.ClanUserListRenderer;
  import flash.events.MouseEvent;

  public class ClanMembersListRenderer extends ClanUserListRenderer {
    public function ClanMembersListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      item = new ClanMemberItem(param1);
      super.data = param1;
    }

    override protected function onRollOut(param1:MouseEvent) : void {
      item.deleteIndicator.visible = false;
      var local2:ClanMemberItem = ClanMemberItem(item);
      if(!local2) {
        super.onRollOut(param1);
        return;
      }
      local2.newIndicator.updateNotifications();
      super.onRollOut(param1);
    }

    override protected function onRollOver(param1:MouseEvent) : void {
      var local2:ClanMemberItem = ClanMemberItem(item);
      if(!local2) {
        super.onRollOver(param1);
        return;
      }
      local2.newIndicator.visible = false;
      super.onRollOver(param1);
    }
  }
}
