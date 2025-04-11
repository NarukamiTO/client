package alternativa.tanks.model.item.item {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class IItemEvents implements IItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPosition() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IItem(this.impl[i]);
          result = int(m.getPosition());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPreviewResource() : ImageResource {
      var result:ImageResource = null;
      var i:int = 0;
      var m:IItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IItem(this.impl[i]);
          result = m.getPreviewResource();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMaxRank() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IItem(this.impl[i]);
          result = int(m.getMaxRank());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMinRank() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IItem(this.impl[i]);
          result = int(m.getMinRank());
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
