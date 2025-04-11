package alternativa.tanks.model.payment.shop.kitviewresource {
  import flash.display.BitmapData;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class KitViewResourceAdapt implements KitViewResource {
    private var object:IGameObject;
    private var impl:KitViewResource;

    public function KitViewResourceAdapt(param1:IGameObject, param2:KitViewResource) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getButtonKitImage() : BitmapData {
      var result:BitmapData = null;
      try {
        Model.object = this.object;
        result = this.impl.getButtonKitImage();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getButtonKitOverImage() : BitmapData {
      var result:BitmapData = null;
      try {
        Model.object = this.object;
        result = this.impl.getButtonKitOverImage();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
