package projects.tanks.client.panel.model.referrals {
  public class ReferralsModelCC {
    private var _inviteLink:String;

    public function ReferralsModelCC(param1:String = null) {
      super();
      this._inviteLink = param1;
    }

    public function get inviteLink() : String {
      return this._inviteLink;
    }

    public function set inviteLink(param1:String) : void {
      this._inviteLink = param1;
    }

    public function toString() : String {
      var local1:String = "ReferralsModelCC [";
      local1 += "inviteLink = " + this.inviteLink + " ";
      return local1 + "]";
    }
  }
}
