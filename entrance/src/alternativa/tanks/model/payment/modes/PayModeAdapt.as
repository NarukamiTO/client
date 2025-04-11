package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeAdapt implements PayMode {
    private var object:IGameObject;
    private var impl:PayMode;

    public function PayModeAdapt(param1:IGameObject, param2:PayMode) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getName() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getName();
      }
      finally {
        Model.popObject();
      }
      return result;
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

    public function hasCustomManualDescription() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasCustomManualDescription());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCustomManualDescription() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getCustomManualDescription();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getOrderIndex() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getOrderIndex());
      }
      finally {
        Model.popObject();
      }
      return result;
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

    public function isDiscount() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isDiscount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function setDiscount(param1:Boolean) : void {
      var value:Boolean = param1;
      try {
        Model.object = this.object;
        this.impl.setDiscount(value);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
