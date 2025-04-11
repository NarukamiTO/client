package projects.tanks.client.clans.panel.foreignclan {
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class ForeignClanCC {
    private var _flags:Vector.<ClanFlag>;

    public function ForeignClanCC(param1:Vector.<ClanFlag> = null) {
      super();
      this._flags = param1;
    }

    public function get flags() : Vector.<ClanFlag> {
      return this._flags;
    }

    public function set flags(param1:Vector.<ClanFlag>) : void {
      this._flags = param1;
    }

    public function toString() : String {
      var local1:String = "ForeignClanCC [";
      local1 += "flags = " + this.flags + " ";
      return local1 + "]";
    }
  }
}
