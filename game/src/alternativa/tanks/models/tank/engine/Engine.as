package alternativa.tanks.models.tank.engine {
  import projects.tanks.client.battlefield.models.tankparts.engine.EngineCC;

  [ModelInterface]
  public interface Engine {
    function getCC() : EngineCC;
  }
}
