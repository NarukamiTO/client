package projects.tanks.client.battleselect.model.matchmaking.group.notify {
  import alternativa.types.Long;
  import projects.tanks.client.commons.types.ItemCategoryEnum;

  public class MountItemsUserData {
    private var _id:Long;
    private var _itemCategory:ItemCategoryEnum;
    private var _modification:int;
    private var _name:String;
    private var _upgradeLevel:int;

    public function MountItemsUserData(param1:Long = null, param2:ItemCategoryEnum = null, param3:int = 0, param4:String = null, param5:int = 0) {
      super();
      this._id = param1;
      this._itemCategory = param2;
      this._modification = param3;
      this._name = param4;
      this._upgradeLevel = param5;
    }

    public function get id() : Long {
      return this._id;
    }

    public function set id(param1:Long) : void {
      this._id = param1;
    }

    public function get itemCategory() : ItemCategoryEnum {
      return this._itemCategory;
    }

    public function set itemCategory(param1:ItemCategoryEnum) : void {
      this._itemCategory = param1;
    }

    public function get modification() : int {
      return this._modification;
    }

    public function set modification(param1:int) : void {
      this._modification = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get upgradeLevel() : int {
      return this._upgradeLevel;
    }

    public function set upgradeLevel(param1:int) : void {
      this._upgradeLevel = param1;
    }

    public function toString() : String {
      var local1:String = "MountItemsUserData [";
      local1 += "id = " + this.id + " ";
      local1 += "itemCategory = " + this.itemCategory + " ";
      local1 += "modification = " + this.modification + " ";
      local1 += "name = " + this.name + " ";
      local1 += "upgradeLevel = " + this.upgradeLevel + " ";
      return local1 + "]";
    }
  }
}
