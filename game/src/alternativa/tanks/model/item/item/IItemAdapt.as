package alternativa.tanks.model.item.item {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class IItemAdapt implements IItem {
    private var object:IGameObject;
    private var impl:IItem;

    public function IItemAdapt(param1:IGameObject, param2:IItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPosition() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPosition());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPreviewResource() : ImageResource {
      var result:ImageResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getPreviewResource();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxRank() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getMaxRank());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMinRank() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getMinRank());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
