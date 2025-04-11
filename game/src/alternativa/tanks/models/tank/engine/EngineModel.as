package alternativa.tanks.models.tank.engine {
  import projects.tanks.client.battlefield.models.tankparts.engine.EngineCC;
  import projects.tanks.client.battlefield.models.tankparts.engine.EngineModelBase;
  import projects.tanks.client.battlefield.models.tankparts.engine.IEngineModelBase;

  [ModelInfo]
  public class EngineModel extends EngineModelBase implements IEngineModelBase, Engine {
    public function EngineModel() {
      super();
    }

    public function getCC() : EngineCC {
      return getInitParam();
    }
  }
}
