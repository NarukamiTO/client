package alternativa.osgi.service.serverlog {
  import alternativa.osgi.service.launcherparams.LauncherParams;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLRequestMethod;

  public class ServerLoggingServiceImpl implements ServerLoggingService {
    private static const LOG_URL_PARAMETER_NAME:String = "serverLogUrl";

    private var logUrl:String;

    public function ServerLoggingServiceImpl(param1:LauncherParams) {
      super();
      this.logUrl = param1.getParameter(LOG_URL_PARAMETER_NAME);
    }

    public function sendDataToServer(param1:String) : void {
      var local2:URLRequest = null;
      if(this.logUrl) {
        local2 = new URLRequest("http://" + this.logUrl);
        local2.method = URLRequestMethod.POST;
        local2.data = param1;
        new URLLoader().load(local2);
      }
    }
  }
}
