package alternativa.tanks.model.item.present {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class PresentImageEvents implements PresentImage {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PresentImageEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getImage() : ImageResource {
      var result:ImageResource = null;
      var i:int = 0;
      var m:PresentImage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PresentImage(this.impl[i]);
          result = m.getImage();
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
