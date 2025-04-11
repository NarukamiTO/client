package alternativa.tanks.models.clan.outgoing {
  import alternativa.tanks.gui.clanmanagement.ClanOutgoingRequestsDialog;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanOutgoingModelAdapt implements IClanOutgoingModel {
    private var object:IGameObject;
    private var impl:IClanOutgoingModel;

    public function IClanOutgoingModelAdapt(param1:IGameObject, param2:IClanOutgoingModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setClanOutgoingWindow(param1:ClanOutgoingRequestsDialog) : void {
      var clanOutgoingWindow:ClanOutgoingRequestsDialog = param1;
      try {
        Model.object = this.object;
        this.impl.setClanOutgoingWindow(clanOutgoingWindow);
      }
      finally {
        Model.popObject();
      }
    }

    public function getUsers() : Vector.<Long> {
      var result:Vector.<Long> = null;
      try {
        Model.object = this.object;
        result = this.impl.getUsers();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
