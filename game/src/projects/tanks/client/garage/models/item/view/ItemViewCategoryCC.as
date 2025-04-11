package projects.tanks.client.garage.models.item.view {
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public class ItemViewCategoryCC {
    private var _category:ItemViewCategoryEnum;

    public function ItemViewCategoryCC(param1:ItemViewCategoryEnum = null) {
      super();
      this._category = param1;
    }

    public function get category() : ItemViewCategoryEnum {
      return this._category;
    }

    public function set category(param1:ItemViewCategoryEnum) : void {
      this._category = param1;
    }

    public function toString() : String {
      var local1:String = "ItemViewCategoryCC [";
      local1 += "category = " + this.category + " ";
      return local1 + "]";
    }
  }
}
