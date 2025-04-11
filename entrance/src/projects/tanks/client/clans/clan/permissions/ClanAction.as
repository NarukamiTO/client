package projects.tanks.client.clans.clan.permissions {
  public class ClanAction {
    public static const DELETE_CLAN:ClanAction = new ClanAction(0,"DELETE_CLAN");
    public static const PERMISSION_DISTRIBUTION:ClanAction = new ClanAction(1,"PERMISSION_DISTRIBUTION");
    public static const REMOVE_FROM_CLAN:ClanAction = new ClanAction(2,"REMOVE_FROM_CLAN");
    public static const ADDING_TO_CLAN:ClanAction = new ClanAction(3,"ADDING_TO_CLAN");
    public static const ACCESS_BLOCK:ClanAction = new ClanAction(4,"ACCESS_BLOCK");
    public static const BATTLE_GROUPS:ClanAction = new ClanAction(5,"BATTLE_GROUPS");
    public static const INVITE_TO_CLAN:ClanAction = new ClanAction(6,"INVITE_TO_CLAN");
    public static const EDIT_PROFILE:ClanAction = new ClanAction(7,"EDIT_PROFILE");

    private var _value:int;
    private var _name:String;

    public function ClanAction(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ClanAction> {
      var local1:Vector.<ClanAction> = new Vector.<ClanAction>();
      local1.push(DELETE_CLAN);
      local1.push(PERMISSION_DISTRIBUTION);
      local1.push(REMOVE_FROM_CLAN);
      local1.push(ADDING_TO_CLAN);
      local1.push(ACCESS_BLOCK);
      local1.push(BATTLE_GROUPS);
      local1.push(INVITE_TO_CLAN);
      local1.push(EDIT_PROFILE);
      return local1;
    }

    public function toString() : String {
      return "ClanAction [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
