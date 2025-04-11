package alternativa.tanks.models.user.outgoing {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanUserOutgoingModelEvents implements IClanUserOutgoingModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanUserOutgoingModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getOutgoingClans() : Vector.<Long> {
      var result:Vector.<Long> = null;
      var i:int = 0;
      var m:IClanUserOutgoingModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanUserOutgoingModel(this.impl[i]);
          result = m.getOutgoingClans();
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
