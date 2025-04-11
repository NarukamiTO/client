package alternativa.tanks.models.clan.incoming {
  import alternativa.tanks.gui.clanmanagement.ClanIncomingRequestsDialog;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.clans.clan.incoming.ClanIncomingModelBase;
  import projects.tanks.client.clans.clan.incoming.IClanIncomingModelBase;

  [ModelInfo]
  public class ClanIncomingModel extends ClanIncomingModelBase implements IClanIncomingModelBase, IClanIncomingModel, ObjectLoadListener {
    private var _users:Vector.<Long>;
    private var _incomingWindow:ClanIncomingRequestsDialog;

    public function ClanIncomingModel() {
      super();
    }

    public function objectLoaded() : void {
      this._users = getInitParam().objects.concat();
    }

    public function onAdding(param1:Long) : void {
      this._users.push(param1);
      if(this._incomingWindow != null) {
        this._incomingWindow.addUser(param1);
      }
    }

    public function onRemoved(param1:Long) : void {
      var local2:Number = Number(this._users.indexOf(param1));
      this._users.splice(local2,1);
      if(this._incomingWindow != null) {
        this._incomingWindow.removeUser(param1);
      }
    }

    public function getUsers() : Vector.<Long> {
      return this._users;
    }

    public function setClanIncomingWindow(param1:ClanIncomingRequestsDialog) : void {
      this._incomingWindow = param1;
    }
  }
}
