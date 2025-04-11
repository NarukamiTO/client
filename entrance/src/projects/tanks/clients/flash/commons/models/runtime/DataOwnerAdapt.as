package projects.tanks.clients.flash.commons.models.runtime {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DataOwnerAdapt implements DataOwner {
    private var object:IGameObject;
    private var impl:DataOwner;

    public function DataOwnerAdapt(param1:IGameObject, param2:DataOwner) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function equals(param1:IGameObject) : Boolean {
      var result:Boolean = false;
      var object:IGameObject = param1;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.equals(object));
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDataOwnerId() : Long {
      var result:Long = null;
      try {
        Model.object = this.object;
        result = this.impl.getDataOwnerId();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
