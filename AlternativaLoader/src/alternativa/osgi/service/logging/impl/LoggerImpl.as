package alternativa.osgi.service.logging.impl {
  import alternativa.osgi.service.logging.LogLevel;
  import alternativa.osgi.service.logging.LogTarget;
  import alternativa.osgi.service.logging.Logger;

  public class LoggerImpl implements Logger {
    private var logTarget:LogTarget;
    private var object:Object;

    public function LoggerImpl(param1:Object, param2:LogTarget) {
      super();
      this.object = param1;
      this.logTarget = param2;
    }

    public function trace(param1:String, param2:Array = null) : void {
      this.logTarget.log(this.object,LogLevel.TRACE,param1,param2);
    }

    public function debug(param1:String, param2:Array = null) : void {
      this.logTarget.log(this.object,LogLevel.DEBUG,param1,param2);
    }

    public function info(param1:String, param2:Array = null) : void {
      this.logTarget.log(this.object,LogLevel.INFO,param1,param2);
    }

    public function warning(param1:String, param2:Array = null) : void {
      this.logTarget.log(this.object,LogLevel.WARNING,param1,param2);
    }

    public function error(param1:String, param2:Array = null) : void {
      this.logTarget.log(this.object,LogLevel.ERROR,param1,param2);
    }
  }
}
