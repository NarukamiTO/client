package projects.tanks.client.panel.model.presents {
  public class PresentsSettingsCC {
    private var _receivePresentsEnabled:Boolean;

    public function PresentsSettingsCC(param1:Boolean = false) {
      super();
      this._receivePresentsEnabled = param1;
    }

    public function get receivePresentsEnabled() : Boolean {
      return this._receivePresentsEnabled;
    }

    public function set receivePresentsEnabled(param1:Boolean) : void {
      this._receivePresentsEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "PresentsSettingsCC [";
      local1 += "receivePresentsEnabled = " + this.receivePresentsEnabled + " ";
      return local1 + "]";
    }
  }
}
