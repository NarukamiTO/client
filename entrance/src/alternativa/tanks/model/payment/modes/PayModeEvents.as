package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeEvents implements PayMode {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayModeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getName() : String {
      var result:String = null;
      var i:int = 0;
      var m:PayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayMode(this.impl[i]);
          result = m.getName();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDescription() : String {
      var result:String = null;
      var i:int = 0;
      var m:PayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayMode(this.impl[i]);
          result = m.getDescription();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasCustomManualDescription() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:PayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayMode(this.impl[i]);
          result = Boolean(m.hasCustomManualDescription());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCustomManualDescription() : String {
      var result:String = null;
      var i:int = 0;
      var m:PayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayMode(this.impl[i]);
          result = m.getCustomManualDescription();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getOrderIndex() : int {
      var result:int = 0;
      var i:int = 0;
      var m:PayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayMode(this.impl[i]);
          result = int(m.getOrderIndex());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getImage() : ImageResource {
      var result:ImageResource = null;
      var i:int = 0;
      var m:PayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayMode(this.impl[i]);
          result = m.getImage();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isDiscount() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:PayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayMode(this.impl[i]);
          result = Boolean(m.isDiscount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function setDiscount(param1:Boolean) : void {
      var i:int = 0;
      var m:PayMode = null;
      var value:Boolean = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayMode(this.impl[i]);
          m.setDiscount(value);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
