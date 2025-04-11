package projects.tanks.client.panel.model.donationalert.user.donation {
  public class DonationProfileCC {
    private var _donator:Boolean;

    public function DonationProfileCC(param1:Boolean = false) {
      super();
      this._donator = param1;
    }

    public function get donator() : Boolean {
      return this._donator;
    }

    public function set donator(param1:Boolean) : void {
      this._donator = param1;
    }

    public function toString() : String {
      var local1:String = "DonationProfileCC [";
      local1 += "donator = " + this.donator + " ";
      return local1 + "]";
    }
  }
}
