package platform.client.fp10.core.service.errormessage.errors {
  public class CannotEstablishConnectionError implements ErrorType {
    private var host:String;
    private var ports:Vector.<int>;

    public function CannotEstablishConnectionError(param1:String, param2:Vector.<int>) {
      super();
      this.host = param1;
      this.ports = param2;
    }

    public function getMessage() : String {
      return "Cannot establish connection (host: " + this.host + ", ports: " + this.ports + ")";
    }
  }
}
