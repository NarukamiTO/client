package projects.tanks.client.panel.model.profile.usersettings {
  public class ClientStoredSettings {
    private var _showDamageEnabled:Boolean;

    public function ClientStoredSettings(param1:Boolean = false) {
      super();
      this._showDamageEnabled = param1;
    }

    public function get showDamageEnabled() : Boolean {
      return this._showDamageEnabled;
    }

    public function set showDamageEnabled(param1:Boolean) : void {
      this._showDamageEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "ClientStoredSettings [";
      local1 += "showDamageEnabled = " + this.showDamageEnabled + " ";
      return local1 + "]";
    }
  }
}
