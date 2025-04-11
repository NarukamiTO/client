package projects.tanks.client.battleselect.model.matchmaking.group.notify {
  import alternativa.types.Long;

  public class MatchmakingUserData {
    private var _armorModification:int;
    private var _armorName:String;
    private var _armorUpgradeLevel:int;
    private var _id:Long;
    private var _leader:Boolean;
    private var _local:Boolean;
    private var _rank:int;
    private var _uid:String;
    private var _userIsReady:Boolean;
    private var _weaponModification:int;
    private var _weaponName:String;
    private var _weaponUpgradeLevel:int;

    public function MatchmakingUserData(param1:int = 0, param2:String = null, param3:int = 0, param4:Long = null, param5:Boolean = false, param6:Boolean = false, param7:int = 0, param8:String = null, param9:Boolean = false, param10:int = 0, param11:String = null, param12:int = 0) {
      super();
      this._armorModification = param1;
      this._armorName = param2;
      this._armorUpgradeLevel = param3;
      this._id = param4;
      this._leader = param5;
      this._local = param6;
      this._rank = param7;
      this._uid = param8;
      this._userIsReady = param9;
      this._weaponModification = param10;
      this._weaponName = param11;
      this._weaponUpgradeLevel = param12;
    }

    public function get armorModification() : int {
      return this._armorModification;
    }

    public function set armorModification(param1:int) : void {
      this._armorModification = param1;
    }

    public function get armorName() : String {
      return this._armorName;
    }

    public function set armorName(param1:String) : void {
      this._armorName = param1;
    }

    public function get armorUpgradeLevel() : int {
      return this._armorUpgradeLevel;
    }

    public function set armorUpgradeLevel(param1:int) : void {
      this._armorUpgradeLevel = param1;
    }

    public function get id() : Long {
      return this._id;
    }

    public function set id(param1:Long) : void {
      this._id = param1;
    }

    public function get leader() : Boolean {
      return this._leader;
    }

    public function set leader(param1:Boolean) : void {
      this._leader = param1;
    }

    public function get local() : Boolean {
      return this._local;
    }

    public function set local(param1:Boolean) : void {
      this._local = param1;
    }

    public function get rank() : int {
      return this._rank;
    }

    public function set rank(param1:int) : void {
      this._rank = param1;
    }

    public function get uid() : String {
      return this._uid;
    }

    public function set uid(param1:String) : void {
      this._uid = param1;
    }

    public function get userIsReady() : Boolean {
      return this._userIsReady;
    }

    public function set userIsReady(param1:Boolean) : void {
      this._userIsReady = param1;
    }

    public function get weaponModification() : int {
      return this._weaponModification;
    }

    public function set weaponModification(param1:int) : void {
      this._weaponModification = param1;
    }

    public function get weaponName() : String {
      return this._weaponName;
    }

    public function set weaponName(param1:String) : void {
      this._weaponName = param1;
    }

    public function get weaponUpgradeLevel() : int {
      return this._weaponUpgradeLevel;
    }

    public function set weaponUpgradeLevel(param1:int) : void {
      this._weaponUpgradeLevel = param1;
    }

    public function toString() : String {
      var local1:String = "MatchmakingUserData [";
      local1 += "armorModification = " + this.armorModification + " ";
      local1 += "armorName = " + this.armorName + " ";
      local1 += "armorUpgradeLevel = " + this.armorUpgradeLevel + " ";
      local1 += "id = " + this.id + " ";
      local1 += "leader = " + this.leader + " ";
      local1 += "local = " + this.local + " ";
      local1 += "rank = " + this.rank + " ";
      local1 += "uid = " + this.uid + " ";
      local1 += "userIsReady = " + this.userIsReady + " ";
      local1 += "weaponModification = " + this.weaponModification + " ";
      local1 += "weaponName = " + this.weaponName + " ";
      local1 += "weaponUpgradeLevel = " + this.weaponUpgradeLevel + " ";
      return local1 + "]";
    }
  }
}
