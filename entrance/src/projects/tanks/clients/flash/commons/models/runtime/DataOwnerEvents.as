package projects.tanks.clients.flash.commons.models.runtime {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DataOwnerEvents implements DataOwner {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function DataOwnerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function equals(param1:IGameObject) : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:DataOwner = null;
      var object:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = DataOwner(this.impl[i]);
          result = Boolean(m.equals(object));
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDataOwnerId() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:DataOwner = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = DataOwner(this.impl[i]);
          result = m.getDataOwnerId();
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
