package alternativa.tanks.models.user.incoming {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanUserIncomingModelEvents implements IClanUserIncomingModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanUserIncomingModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getIncomingClans() : Vector.<Long> {
      var result:Vector.<Long> = null;
      var i:int = 0;
      var m:IClanUserIncomingModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanUserIncomingModel(this.impl[i]);
          result = m.getIncomingClans();
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
