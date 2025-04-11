package alternativa.tanks.model.payment.modes.description {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeBottomDescriptionAdapt implements PayModeBottomDescription {
    private var object:IGameObject;
    private var impl:PayModeBottomDescription;

    public function PayModeBottomDescriptionAdapt(param1:IGameObject, param2:PayModeBottomDescription) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDescription() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getDescription();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getImages() : Vector.<ImageResource> {
      var result:Vector.<ImageResource> = null;
      try {
        Model.object = this.object;
        result = this.impl.getImages();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function enabled() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.enabled());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
