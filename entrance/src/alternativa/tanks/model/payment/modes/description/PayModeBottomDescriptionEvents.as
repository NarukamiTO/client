package alternativa.tanks.model.payment.modes.description {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeBottomDescriptionEvents implements PayModeBottomDescription {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayModeBottomDescriptionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDescription() : String {
      var result:String = null;
      var i:int = 0;
      var m:PayModeBottomDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeBottomDescription(this.impl[i]);
          result = m.getDescription();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getImages() : Vector.<ImageResource> {
      var result:Vector.<ImageResource> = null;
      var i:int = 0;
      var m:PayModeBottomDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeBottomDescription(this.impl[i]);
          result = m.getImages();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function enabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:PayModeBottomDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeBottomDescription(this.impl[i]);
          result = Boolean(m.enabled());
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
