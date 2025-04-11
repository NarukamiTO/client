package projects.tanks.client.tanksservices.model.notifier.online {
  import alternativa.types.Long;
  import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;

  public class OnlineNotifierData extends AbstractNotifier {
    private var _online:Boolean;
    private var _serverNumber:int;
    private var _timeSinceLastVisitInSec:Long;

    public function OnlineNotifierData(param1:Boolean = false, param2:int = 0, param3:Long = null) {
      super();
      this._online = param1;
      this._serverNumber = param2;
      this._timeSinceLastVisitInSec = param3;
    }

    public function get online() : Boolean {
      return this._online;
    }

    public function set online(param1:Boolean) : void {
      this._online = param1;
    }

    public function get serverNumber() : int {
      return this._serverNumber;
    }

    public function set serverNumber(param1:int) : void {
      this._serverNumber = param1;
    }

    public function get timeSinceLastVisitInSec() : Long {
      return this._timeSinceLastVisitInSec;
    }

    public function set timeSinceLastVisitInSec(param1:Long) : void {
      this._timeSinceLastVisitInSec = param1;
    }

    override public function toString() : String {
      var local1:String = "OnlineNotifierData [";
      local1 += "online = " + this.online + " ";
      local1 += "serverNumber = " + this.serverNumber + " ";
      local1 += "timeSinceLastVisitInSec = " + this.timeSinceLastVisitInSec + " ";
      local1 += super.toString();
      return local1 + "]";
    }
  }
}
