package alternativa.tanks.models.clan.incoming {
  import alternativa.tanks.gui.clanmanagement.ClanIncomingRequestsDialog;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanIncomingModelEvents implements IClanIncomingModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanIncomingModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getUsers() : Vector.<Long> {
      var result:Vector.<Long> = null;
      var i:int = 0;
      var m:IClanIncomingModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanIncomingModel(this.impl[i]);
          result = m.getUsers();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function setClanIncomingWindow(param1:ClanIncomingRequestsDialog) : void {
      var i:int = 0;
      var m:IClanIncomingModel = null;
      var window:ClanIncomingRequestsDialog = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanIncomingModel(this.impl[i]);
          m.setClanIncomingWindow(window);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
