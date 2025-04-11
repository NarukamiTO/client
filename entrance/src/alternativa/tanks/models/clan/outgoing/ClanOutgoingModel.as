package alternativa.tanks.models.clan.outgoing {
  import alternativa.tanks.gui.clanmanagement.ClanOutgoingRequestsDialog;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.clans.clan.outgoing.ClanOutgoingModelBase;
  import projects.tanks.client.clans.clan.outgoing.IClanOutgoingModelBase;

  [ModelInfo]
  public class ClanOutgoingModel extends ClanOutgoingModelBase implements IClanOutgoingModelBase, IClanOutgoingModel, ObjectLoadListener {
    private var _outgoingWindow:ClanOutgoingRequestsDialog;
    private var _users:Vector.<Long> = new Vector.<Long>();

    public function ClanOutgoingModel() {
      super();
    }

    public function objectLoaded() : void {
      this._users = getInitParam().objects.concat();
    }

    public function setClanOutgoingWindow(param1:ClanOutgoingRequestsDialog) : void {
      this._outgoingWindow = param1;
    }

    public function onAdding(param1:Long) : void {
      this._users.push(param1);
      if(this._outgoingWindow != null) {
        this._outgoingWindow.addUser(param1);
      }
    }

    public function onRemoved(param1:Long) : void {
      var local2:Number = Number(this._users.indexOf(param1));
      this._users.splice(local2,1);
      if(this._outgoingWindow != null) {
        this._outgoingWindow.removeUser(param1);
      }
    }

    public function getUsers() : Vector.<Long> {
      return this._users;
    }
  }
}
