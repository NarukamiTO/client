package alternativa.tanks.model.payment.modes.errors {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ErrorDescriptionEvents implements ErrorDescription {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ErrorDescriptionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showError(param1:int) : void {
      var i:int = 0;
      var m:ErrorDescription = null;
      var errorCode:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ErrorDescription(this.impl[i]);
          m.showError(errorCode);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showUnknownError() : void {
      var i:int = 0;
      var m:ErrorDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ErrorDescription(this.impl[i]);
          m.showUnknownError();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
