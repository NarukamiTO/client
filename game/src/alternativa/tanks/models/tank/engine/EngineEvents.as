package alternativa.tanks.models.tank.engine {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.engine.EngineCC;

  public class EngineEvents implements Engine {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function EngineEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCC() : EngineCC {
      var result:EngineCC = null;
      var i:int = 0;
      var m:Engine = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = Engine(this.impl[i]);
          result = m.getCC();
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
