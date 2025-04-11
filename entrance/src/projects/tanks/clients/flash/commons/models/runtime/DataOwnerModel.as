package projects.tanks.clients.flash.commons.models.runtime {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.runtime.DataOwnerModelBase;
  import projects.tanks.client.commons.models.runtime.IDataOwnerModelBase;

  [ModelInfo]
  public class DataOwnerModel extends DataOwnerModelBase implements IDataOwnerModelBase, DataOwner {
    public function DataOwnerModel() {
      super();
    }

    public function equals(param1:IGameObject) : Boolean {
      var local2:Long = this.getDataOwnerId();
      var local3:Long = this.getDataOwnerIdFor(param1);
      return local2.high == local3.high && local2.low == local3.low;
    }

    public function getDataOwnerId() : Long {
      return getInitParam().dataOwnerId;
    }

    private function getDataOwnerIdFor(param1:IGameObject) : Long {
      var local2:Long = null;
      Model.object = param1;
      local2 = getInitParam().dataOwnerId;
      Model.popObject();
      return local2;
    }
  }
}
