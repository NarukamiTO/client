package projects.tanks.client.panel.model.abonements {
  import alternativa.types.Long;
  import projects.tanks.client.commons.types.ShopAbonementBonusTypeEnum;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class ShopAbonementData {
    private var _bonusType:ShopAbonementBonusTypeEnum;
    private var _remainingTime:Long;
    private var _shopCategory:ShopCategoryEnum;

    public function ShopAbonementData(param1:ShopAbonementBonusTypeEnum = null, param2:Long = null, param3:ShopCategoryEnum = null) {
      super();
      this._bonusType = param1;
      this._remainingTime = param2;
      this._shopCategory = param3;
    }

    public function get bonusType() : ShopAbonementBonusTypeEnum {
      return this._bonusType;
    }

    public function set bonusType(param1:ShopAbonementBonusTypeEnum) : void {
      this._bonusType = param1;
    }

    public function get remainingTime() : Long {
      return this._remainingTime;
    }

    public function set remainingTime(param1:Long) : void {
      this._remainingTime = param1;
    }

    public function get shopCategory() : ShopCategoryEnum {
      return this._shopCategory;
    }

    public function set shopCategory(param1:ShopCategoryEnum) : void {
      this._shopCategory = param1;
    }

    public function toString() : String {
      var local1:String = "ShopAbonementData [";
      local1 += "bonusType = " + this.bonusType + " ";
      local1 += "remainingTime = " + this.remainingTime + " ";
      local1 += "shopCategory = " + this.shopCategory + " ";
      return local1 + "]";
    }
  }
}
