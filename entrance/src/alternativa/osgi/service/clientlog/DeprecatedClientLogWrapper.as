package alternativa.osgi.service.clientlog {
  import alternativa.osgi.service.logging.LogService;

  public class DeprecatedClientLogWrapper implements IClientLogBase {
    private var logService:LogService;

    public function DeprecatedClientLogWrapper(param1:LogService) {
      super();
      this.logService = param1;
    }

    public function log(param1:String, param2:String, ... rest) : void {
      this.logService.getLogger(param1).info(param2,rest);
    }
  }
}
