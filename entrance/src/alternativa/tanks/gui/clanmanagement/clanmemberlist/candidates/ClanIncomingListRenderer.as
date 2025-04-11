package alternativa.tanks.gui.clanmanagement.clanmemberlist.candidates {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.*;
  import flash.events.MouseEvent;

  public class ClanIncomingListRenderer extends ClanUserListRenderer {
    public function ClanIncomingListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      item = new ClanIncomingRequestItem(param1.id);
      super.data = param1;
    }

    override protected function onRollOut(param1:MouseEvent) : void {
      item.deleteIndicator.visible = false;
      item.acceptedIndicator.visible = false;
      ClanIncomingRequestItem(item).newIndicator.show();
      ClanIncomingRequestItem(item).newIndicator.updateNotifications();
      super.onRollOut(param1);
    }

    override protected function onRollOver(param1:MouseEvent) : void {
      item.acceptedIndicator.visible = true;
      ClanIncomingRequestItem(item).newIndicator.hide();
      ClanIncomingRequestItem(item).newIndicator.updateNotifications();
      super.onRollOver(param1);
    }
  }
}
