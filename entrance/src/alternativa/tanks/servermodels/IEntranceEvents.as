package alternativa.tanks.servermodels {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IEntranceEvents implements IEntrance {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IEntranceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function currentState(param1:ILeavableEntranceState) : void {
      var i:int = 0;
      var m:IEntrance = null;
      var state:ILeavableEntranceState = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IEntrance(this.impl[i]);
          m.currentState(state);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function decideWhereToGoAfterStandAloneCaptcha(param1:ILeavableEntranceState, param2:Boolean) : void {
      var i:int = 0;
      var m:IEntrance = null;
      var captchaModel:ILeavableEntranceState = param1;
      var confirmEmail:Boolean = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IEntrance(this.impl[i]);
          m.decideWhereToGoAfterStandAloneCaptcha(captchaModel,confirmEmail);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function antiAddiction() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IEntrance = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IEntrance(this.impl[i]);
          result = Boolean(m.antiAddiction());
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
