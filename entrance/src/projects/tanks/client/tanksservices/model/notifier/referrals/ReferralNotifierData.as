package projects.tanks.client.tanksservices.model.notifier.referrals {
  import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;

  public class ReferralNotifierData extends AbstractNotifier {
    private var _referral:Boolean;

    public function ReferralNotifierData(param1:Boolean = false) {
      super();
      this._referral = param1;
    }

    public function get referral() : Boolean {
      return this._referral;
    }

    public function set referral(param1:Boolean) : void {
      this._referral = param1;
    }

    override public function toString() : String {
      var local1:String = "ReferralNotifierData [";
      local1 += "referral = " + this.referral + " ";
      local1 += super.toString();
      return local1 + "]";
    }
  }
}
