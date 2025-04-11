package alternativa.tanks.models.latency {
  import projects.tanks.client.battleservice.model.latency.ILatencyModelBase;
  import projects.tanks.client.battleservice.model.latency.LatencyModelBase;

  [ModelInfo]
  public class LatencyModel extends LatencyModelBase implements ILatencyModelBase {
    public function LatencyModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function ping() : void {
      server.pong();
    }
  }
}
