package alternativa.tanks.gui.clanmanagement.clanmemberlist.candidates {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.*;

  public class ClanOutgoingListRenderer extends ClanUserListRenderer {
    public function ClanOutgoingListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      item = new ClanOutgoingRequestsItem(param1.id);
      super.data = param1;
    }
  }
}
