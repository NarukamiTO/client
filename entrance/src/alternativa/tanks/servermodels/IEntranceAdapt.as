package alternativa.tanks.servermodels {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IEntranceAdapt implements IEntrance {
    private var object:IGameObject;
    private var impl:IEntrance;

    public function IEntranceAdapt(param1:IGameObject, param2:IEntrance) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function currentState(param1:ILeavableEntranceState) : void {
      var state:ILeavableEntranceState = param1;
      try {
        Model.object = this.object;
        this.impl.currentState(state);
      }
      finally {
        Model.popObject();
      }
    }

    public function decideWhereToGoAfterStandAloneCaptcha(param1:ILeavableEntranceState, param2:Boolean) : void {
      var captchaModel:ILeavableEntranceState = param1;
      var confirmEmail:Boolean = param2;
      try {
        Model.object = this.object;
        this.impl.decideWhereToGoAfterStandAloneCaptcha(captchaModel,confirmEmail);
      }
      finally {
        Model.popObject();
      }
    }

    public function antiAddiction() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.antiAddiction());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
