package alternativa.tanks.models.user.incoming {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanUserIncomingModelAdapt implements IClanUserIncomingModel {
    private var object:IGameObject;
    private var impl:IClanUserIncomingModel;

    public function IClanUserIncomingModelAdapt(param1:IGameObject, param2:IClanUserIncomingModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getIncomingClans() : Vector.<Long> {
      var result:Vector.<Long> = null;
      try {
        Model.object = this.object;
        result = this.impl.getIncomingClans();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
