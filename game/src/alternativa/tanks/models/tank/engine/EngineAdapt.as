package alternativa.tanks.models.tank.engine {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.engine.EngineCC;

  public class EngineAdapt implements Engine {
    private var object:IGameObject;
    private var impl:Engine;

    public function EngineAdapt(param1:IGameObject, param2:Engine) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCC() : EngineCC {
      var result:EngineCC = null;
      try {
        Model.object = this.object;
        result = this.impl.getCC();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
