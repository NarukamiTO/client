package alternativa.tanks.models.panel.clanpanel {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanPanelModelAdapt implements IClanPanelModel {
    private var object:IGameObject;
    private var impl:IClanPanelModel;

    public function IClanPanelModelAdapt(param1:IGameObject, param2:IClanPanelModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function sendInviteToClan(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.sendInviteToClan(userId);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
