package projects.tanks.client.tanksservices.model.proabonementnotifier {
  public class ProAbonementNotifierCC {
    private var _abonementRemainingTimeInSec:int;

    public function ProAbonementNotifierCC(param1:int = 0) {
      super();
      this._abonementRemainingTimeInSec = param1;
    }

    public function get abonementRemainingTimeInSec() : int {
      return this._abonementRemainingTimeInSec;
    }

    public function set abonementRemainingTimeInSec(param1:int) : void {
      this._abonementRemainingTimeInSec = param1;
    }

    public function toString() : String {
      var local1:String = "ProAbonementNotifierCC [";
      local1 += "abonementRemainingTimeInSec = " + this.abonementRemainingTimeInSec + " ";
      return local1 + "]";
    }
  }
}
