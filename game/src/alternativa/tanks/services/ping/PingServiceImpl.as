package alternativa.tanks.services.ping {
  public class PingServiceImpl implements PingService {
    private var ping:Number = 0;

    public function PingServiceImpl() {
      super();
    }

    public function getPing() : Number {
      return this.ping;
    }

    public function setPing(param1:Number) : void {
      this.ping = param1;
    }
  }
}
