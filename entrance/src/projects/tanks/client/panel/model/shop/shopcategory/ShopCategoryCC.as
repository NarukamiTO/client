package projects.tanks.client.panel.model.shop.shopcategory {
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class ShopCategoryCC {
    private var _orderIndex:int;
    private var _type:ShopCategoryEnum;
    private var _withJumpButton:Boolean;

    public function ShopCategoryCC(param1:int = 0, param2:ShopCategoryEnum = null, param3:Boolean = false) {
      super();
      this._orderIndex = param1;
      this._type = param2;
      this._withJumpButton = param3;
    }

    public function get orderIndex() : int {
      return this._orderIndex;
    }

    public function set orderIndex(param1:int) : void {
      this._orderIndex = param1;
    }

    public function get type() : ShopCategoryEnum {
      return this._type;
    }

    public function set type(param1:ShopCategoryEnum) : void {
      this._type = param1;
    }

    public function get withJumpButton() : Boolean {
      return this._withJumpButton;
    }

    public function set withJumpButton(param1:Boolean) : void {
      this._withJumpButton = param1;
    }

    public function toString() : String {
      var local1:String = "ShopCategoryCC [";
      local1 += "orderIndex = " + this.orderIndex + " ";
      local1 += "type = " + this.type + " ";
      local1 += "withJumpButton = " + this.withJumpButton + " ";
      return local1 + "]";
    }
  }
}
