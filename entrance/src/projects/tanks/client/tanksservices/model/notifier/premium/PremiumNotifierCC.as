package projects.tanks.client.tanksservices.model.notifier.premium {
  public class PremiumNotifierCC {
    private var _lifeTimeInSeconds:int;

    public function PremiumNotifierCC(param1:int = 0) {
      super();
      this._lifeTimeInSeconds = param1;
    }

    public function get lifeTimeInSeconds() : int {
      return this._lifeTimeInSeconds;
    }

    public function set lifeTimeInSeconds(param1:int) : void {
      this._lifeTimeInSeconds = param1;
    }

    public function toString() : String {
      var local1:String = "PremiumNotifierCC [";
      local1 += "lifeTimeInSeconds = " + this.lifeTimeInSeconds + " ";
      return local1 + "]";
    }
  }
}
