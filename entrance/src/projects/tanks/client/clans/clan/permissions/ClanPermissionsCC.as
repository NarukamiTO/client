package projects.tanks.client.clans.clan.permissions {
  public class ClanPermissionsCC {
    private var _actions:Vector.<ClanAction>;

    public function ClanPermissionsCC(param1:Vector.<ClanAction> = null) {
      super();
      this._actions = param1;
    }

    public function get actions() : Vector.<ClanAction> {
      return this._actions;
    }

    public function set actions(param1:Vector.<ClanAction>) : void {
      this._actions = param1;
    }

    public function toString() : String {
      var local1:String = "ClanPermissionsCC [";
      local1 += "actions = " + this.actions + " ";
      return local1 + "]";
    }
  }
}
