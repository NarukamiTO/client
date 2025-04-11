package alternativa.osgi.service.serverlog {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.logging.LogService;

  public class ServerLoggingServiceStub implements ServerLoggingService {
    private const FAKE_SERVER_LOGGING_CHANNEL_NAME:String = "fake_server_logs";

    public function ServerLoggingServiceStub() {
      super();
    }

    public function sendDataToServer(param1:String) : void {
      LogService(OSGi.getInstance().getService(LogService)).getLogger(this.FAKE_SERVER_LOGGING_CHANNEL_NAME).error(param1);
    }
  }
}
