package alternativa.tanks.model.payment.modes.errors {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ErrorDescriptionAdapt implements ErrorDescription {
    private var object:IGameObject;
    private var impl:ErrorDescription;

    public function ErrorDescriptionAdapt(param1:IGameObject, param2:ErrorDescription) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showError(param1:int) : void {
      var errorCode:int = param1;
      try {
        Model.object = this.object;
        this.impl.showError(errorCode);
      }
      finally {
        Model.popObject();
      }
    }

    public function showUnknownError() : void {
      try {
        Model.object = this.object;
        this.impl.showUnknownError();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
