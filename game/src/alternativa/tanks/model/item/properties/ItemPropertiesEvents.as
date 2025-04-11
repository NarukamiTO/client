package alternativa.tanks.model.item.properties {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ItemPropertiesEvents implements ItemProperties {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ItemPropertiesEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getProperties() : Vector.<ItemPropertyValue> {
      var result:Vector.<ItemPropertyValue> = null;
      var i:int = 0;
      var m:ItemProperties = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemProperties(this.impl[i]);
          result = m.getProperties();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPropertiesForInfoWindow() : Vector.<ItemPropertyValue> {
      var result:Vector.<ItemPropertyValue> = null;
      var i:int = 0;
      var m:ItemProperties = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemProperties(this.impl[i]);
          result = m.getPropertiesForInfoWindow();
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
