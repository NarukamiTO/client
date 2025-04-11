package projects.tanks.client.panel.model.profile.useremailpassword {
  public class UserEmailCC {
    private var _email:String;
    private var _emailConfirmed:Boolean;

    public function UserEmailCC(param1:String = null, param2:Boolean = false) {
      super();
      this._email = param1;
      this._emailConfirmed = param2;
    }

    public function get email() : String {
      return this._email;
    }

    public function set email(param1:String) : void {
      this._email = param1;
    }

    public function get emailConfirmed() : Boolean {
      return this._emailConfirmed;
    }

    public function set emailConfirmed(param1:Boolean) : void {
      this._emailConfirmed = param1;
    }

    public function toString() : String {
      var local1:String = "UserEmailCC [";
      local1 += "email = " + this.email + " ";
      local1 += "emailConfirmed = " + this.emailConfirmed + " ";
      return local1 + "]";
    }
  }
}
