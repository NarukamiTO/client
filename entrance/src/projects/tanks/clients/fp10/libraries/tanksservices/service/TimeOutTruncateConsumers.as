package projects.tanks.clients.fp10.libraries.tanksservices.service {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import flash.utils.clearInterval;
  import flash.utils.setInterval;

  public class TimeOutTruncateConsumers {
    [Inject]
    public static var logService:LogService;

    private const TRUNCATE_PERIOD:int = 300000;

    private var _intervalId:uint;
    private var _consumersLastAccessTime:Dictionary = new Dictionary();
    private var _consumers:Dictionary;
    private var _truncateFunction:Function;

    public function TimeOutTruncateConsumers() {
      super();
      this._intervalId = setInterval(this.truncateOutdatedConsumers,this.TRUNCATE_PERIOD);
    }

    public function get truncateFunction() : Function {
      return this._truncateFunction;
    }

    public function set truncateFunction(param1:Function) : void {
      this._truncateFunction = param1;
    }

    private function truncateOutdatedConsumers() : void {
      var local3:* = undefined;
      var local4:IInfoLabelUpdater = null;
      if(this.truncateFunction == null) {
        return;
      }
      var local1:Vector.<Long> = new Vector.<Long>();
      var local2:Number = new Date().time - this.TRUNCATE_PERIOD;
      for(local3 in this._consumers) {
        local4 = this._consumers[local3];
        if(local4.lastAccessTime < local2 && local4.visibleLabelsCounter == 0) {
          local1.push(local3);
        }
      }
      if(local1.length > 0) {
        this.truncateFunction(local1);
      }
    }

    public function updateLastAccessTime(param1:Long) : void {
      this._consumersLastAccessTime[param1] = new Date().time;
    }

    public function set consumers(param1:Dictionary) : void {
      this._consumers = param1;
    }

    public function stop() : void {
      clearInterval(this._intervalId);
    }
  }
}
