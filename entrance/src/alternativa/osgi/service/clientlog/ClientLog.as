package alternativa.osgi.service.clientlog {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;

  public class ClientLog implements IClientLog {
    private var logService:LogService;

    public function ClientLog(param1:LogService) {
      super();
      this.logService = param1;
    }

    public function logInternal(param1:String, param2:String, param3:Array = null) : void {
      this.getLogger(param1).info(param2,param3);
    }

    public function log(param1:String, param2:String, ... rest) : void {
      this.getLogger(param1).debug(param2,rest);
    }

    public function logError(param1:String, param2:String, ... rest) : void {
      this.getLogger(param1).error(param2,rest);
    }

    private function getLogger(param1:String) : Logger {
      return this.logService.getLogger(param1);
    }

    public function getChannelStrings(param1:String) : Vector.<String> {
      return null;
    }

    public function addLogListener(param1:IClientLogChannelListener) : void {
    }

    public function removeLogListener(param1:IClientLogChannelListener) : void {
    }

    public function addLogChannelListener(param1:String, param2:IClientLogChannelListener) : void {
    }

    public function removeLogChannelListener(param1:String, param2:IClientLogChannelListener) : void {
    }

    public function getChannelNames() : Vector.<String> {
      return null;
    }
  }
}
