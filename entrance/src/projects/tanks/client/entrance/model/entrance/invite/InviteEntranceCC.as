package projects.tanks.client.entrance.model.entrance.invite {
  public class InviteEntranceCC {
    private var _enabled:Boolean;

    public function InviteEntranceCC(param1:Boolean = false) {
      super();
      this._enabled = param1;
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
    }

    public function toString() : String {
      var local1:String = "InviteEntranceCC [";
      local1 += "enabled = " + this.enabled + " ";
      return local1 + "]";
    }
  }
}
