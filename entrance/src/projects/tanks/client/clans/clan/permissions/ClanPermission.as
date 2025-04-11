package projects.tanks.client.clans.clan.permissions {
  public class ClanPermission {
    public static const SUPREME_COMMANDER:ClanPermission = new ClanPermission(0,"SUPREME_COMMANDER");
    public static const COMMANDER:ClanPermission = new ClanPermission(1,"COMMANDER");
    public static const OFFICER:ClanPermission = new ClanPermission(2,"OFFICER");
    public static const SERGEANT:ClanPermission = new ClanPermission(3,"SERGEANT");
    public static const VETERAN:ClanPermission = new ClanPermission(4,"VETERAN");
    public static const PRIVATE:ClanPermission = new ClanPermission(5,"PRIVATE");
    public static const NOVICE:ClanPermission = new ClanPermission(6,"NOVICE");

    private var _value:int;
    private var _name:String;

    public function ClanPermission(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<ClanPermission> {
      var local1:Vector.<ClanPermission> = new Vector.<ClanPermission>();
      local1.push(SUPREME_COMMANDER);
      local1.push(COMMANDER);
      local1.push(OFFICER);
      local1.push(SERGEANT);
      local1.push(VETERAN);
      local1.push(PRIVATE);
      local1.push(NOVICE);
      return local1;
    }

    public function toString() : String {
      return "ClanPermission [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
