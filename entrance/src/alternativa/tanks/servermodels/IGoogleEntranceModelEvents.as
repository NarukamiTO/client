package alternativa.tanks.servermodels {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IGoogleEntranceModelEvents implements IGoogleEntranceModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IGoogleEntranceModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function login(param1:String) : void {
      var i:int = 0;
      var m:IGoogleEntranceModel = null;
      var token:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IGoogleEntranceModel(this.impl[i]);
          m.login(token);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
