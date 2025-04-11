package alternativa.tanks.models.clan.accepted {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanAcceptedModelAdapt implements IClanAcceptedModel {
    private var object:IGameObject;
    private var impl:IClanAcceptedModel;

    public function IClanAcceptedModelAdapt(param1:IGameObject, param2:IClanAcceptedModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getAcceptedUsers() : Vector.<Long> {
      var result:Vector.<Long> = null;
      try {
        Model.object = this.object;
        result = this.impl.getAcceptedUsers();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
