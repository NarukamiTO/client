package platform.client.fp10.core.service.errormessage.errors {
  public class TransportError implements ErrorType {
    public function TransportError() {
      super();
    }

    public function getMessage() : String {
      return "Connection closed because of transport error";
    }
  }
}
