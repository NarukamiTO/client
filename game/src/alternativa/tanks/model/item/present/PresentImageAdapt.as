package alternativa.tanks.model.item.present {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class PresentImageAdapt implements PresentImage {
    private var object:IGameObject;
    private var impl:PresentImage;

    public function PresentImageAdapt(param1:IGameObject, param2:PresentImage) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getImage() : ImageResource {
      var result:ImageResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getImage();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
