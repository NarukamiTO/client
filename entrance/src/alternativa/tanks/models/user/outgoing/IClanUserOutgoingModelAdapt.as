package alternativa.tanks.models.user.outgoing {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanUserOutgoingModelAdapt implements IClanUserOutgoingModel {
    private var object:IGameObject;
    private var impl:IClanUserOutgoingModel;

    public function IClanUserOutgoingModelAdapt(param1:IGameObject, param2:IClanUserOutgoingModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getOutgoingClans() : Vector.<Long> {
      var result:Vector.<Long> = null;
      try {
        Model.object = this.object;
        result = this.impl.getOutgoingClans();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
