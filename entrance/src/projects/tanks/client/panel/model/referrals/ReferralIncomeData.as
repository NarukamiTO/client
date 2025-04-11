package projects.tanks.client.panel.model.referrals {
  import alternativa.types.Long;

  public class ReferralIncomeData {
    private var _income:int;
    private var _user:Long;

    public function ReferralIncomeData(param1:int = 0, param2:Long = null) {
      super();
      this._income = param1;
      this._user = param2;
    }

    public function get income() : int {
      return this._income;
    }

    public function set income(param1:int) : void {
      this._income = param1;
    }

    public function get user() : Long {
      return this._user;
    }

    public function set user(param1:Long) : void {
      this._user = param1;
    }

    public function toString() : String {
      var local1:String = "ReferralIncomeData [";
      local1 += "income = " + this.income + " ";
      local1 += "user = " + this.user + " ";
      return local1 + "]";
    }
  }
}
