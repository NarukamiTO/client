package alternativa.tanks.models.panel.clanpanel {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanPanelModelEvents implements IClanPanelModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanPanelModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function sendInviteToClan(param1:Long) : void {
      var i:int = 0;
      var m:IClanPanelModel = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanPanelModel(this.impl[i]);
          m.sendInviteToClan(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
