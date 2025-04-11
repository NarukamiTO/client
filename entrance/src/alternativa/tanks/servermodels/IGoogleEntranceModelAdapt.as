package alternativa.tanks.servermodels {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IGoogleEntranceModelAdapt implements IGoogleEntranceModel {
    private var object:IGameObject;
    private var impl:IGoogleEntranceModel;

    public function IGoogleEntranceModelAdapt(param1:IGameObject, param2:IGoogleEntranceModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function login(param1:String) : void {
      var token:String = param1;
      try {
        Model.object = this.object;
        this.impl.login(token);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
