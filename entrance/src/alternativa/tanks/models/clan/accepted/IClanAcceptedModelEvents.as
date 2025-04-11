package alternativa.tanks.models.clan.accepted {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanAcceptedModelEvents implements IClanAcceptedModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanAcceptedModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getAcceptedUsers() : Vector.<Long> {
      var result:Vector.<Long> = null;
      var i:int = 0;
      var m:IClanAcceptedModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanAcceptedModel(this.impl[i]);
          result = m.getAcceptedUsers();
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
