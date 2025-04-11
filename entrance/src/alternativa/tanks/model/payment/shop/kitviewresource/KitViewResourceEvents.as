package alternativa.tanks.model.payment.shop.kitviewresource {
  import flash.display.BitmapData;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class KitViewResourceEvents implements KitViewResource {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function KitViewResourceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getButtonKitImage() : BitmapData {
      var result:BitmapData = null;
      var i:int = 0;
      var m:KitViewResource = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = KitViewResource(this.impl[i]);
          result = m.getButtonKitImage();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getButtonKitOverImage() : BitmapData {
      var result:BitmapData = null;
      var i:int = 0;
      var m:KitViewResource = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = KitViewResource(this.impl[i]);
          result = m.getButtonKitOverImage();
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
