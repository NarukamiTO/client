package alternativa.tanks.models.timechecker {
  import alternativa.tanks.services.ping.PingService;
  import flash.utils.getTimer;
  import projects.tanks.client.battlefield.models.anticheat.timechecker.ITimeCheckerModelBase;
  import projects.tanks.client.battlefield.models.anticheat.timechecker.TimeCheckerModelBase;

  [ModelInfo]
  public class TimeCheckerModel extends TimeCheckerModelBase implements ITimeCheckerModelBase {
    [Inject]
    public static var pingService:PingService;

    public function TimeCheckerModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function ping(param1:int, param2:Number) : void {
      server.pong(getTimer(),param1);
      pingService.setPing(param2);
    }
  }
}
