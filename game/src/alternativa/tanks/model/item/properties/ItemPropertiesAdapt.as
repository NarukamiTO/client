package alternativa.tanks.model.item.properties {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ItemPropertiesAdapt implements ItemProperties {
    private var object:IGameObject;
    private var impl:ItemProperties;

    public function ItemPropertiesAdapt(param1:IGameObject, param2:ItemProperties) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getProperties() : Vector.<ItemPropertyValue> {
      var result:Vector.<ItemPropertyValue> = null;
      try {
        Model.object = this.object;
        result = this.impl.getProperties();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPropertiesForInfoWindow() : Vector.<ItemPropertyValue> {
      var result:Vector.<ItemPropertyValue> = null;
      try {
        Model.object = this.object;
        result = this.impl.getPropertiesForInfoWindow();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
