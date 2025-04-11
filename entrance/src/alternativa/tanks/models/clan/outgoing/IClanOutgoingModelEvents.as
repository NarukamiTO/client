package alternativa.tanks.models.clan.outgoing {
  import alternativa.tanks.gui.clanmanagement.ClanOutgoingRequestsDialog;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanOutgoingModelEvents implements IClanOutgoingModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanOutgoingModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setClanOutgoingWindow(param1:ClanOutgoingRequestsDialog) : void {
      var i:int = 0;
      var m:IClanOutgoingModel = null;
      var clanOutgoingWindow:ClanOutgoingRequestsDialog = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanOutgoingModel(this.impl[i]);
          m.setClanOutgoingWindow(clanOutgoingWindow);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getUsers() : Vector.<Long> {
      var result:Vector.<Long> = null;
      var i:int = 0;
      var m:IClanOutgoingModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanOutgoingModel(this.impl[i]);
          result = m.getUsers();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
