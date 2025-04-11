package platform.client.fp10.core.service.errormessage.errors {
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;

  public class ConnectionClosedError implements ErrorType {
    private var closeStatus:ConnectionCloseStatus;

    public function ConnectionClosedError(param1:ConnectionCloseStatus) {
      super();
      this.closeStatus = param1;
    }

    public function getMessage() : String {
      return this.closeStatus.defaultMessage;
    }
  }
}
