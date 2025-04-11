package alternativa.tanks.models.clan.incoming {
  import alternativa.tanks.gui.clanmanagement.ClanIncomingRequestsDialog;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanIncomingModelAdapt implements IClanIncomingModel {
    private var object:IGameObject;
    private var impl:IClanIncomingModel;

    public function IClanIncomingModelAdapt(param1:IGameObject, param2:IClanIncomingModel) {
      super();
      this.object = param1;
      this.impl = param2;
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

    public function setClanIncomingWindow(param1:ClanIncomingRequestsDialog) : void {
      var window:ClanIncomingRequestsDialog = param1;
      try {
        Model.object = this.object;
        this.impl.setClanIncomingWindow(window);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
