package projects.tanks.client.garage.models.item.discount.proabonement {
  public class ProAbonementRankDiscountCC {
    private var _percentDiscountPerRank:Number;

    public function ProAbonementRankDiscountCC(param1:Number = 0) {
      super();
      this._percentDiscountPerRank = param1;
    }

    public function get percentDiscountPerRank() : Number {
      return this._percentDiscountPerRank;
    }

    public function set percentDiscountPerRank(param1:Number) : void {
      this._percentDiscountPerRank = param1;
    }

    public function toString() : String {
      var local1:String = "ProAbonementRankDiscountCC [";
      local1 += "percentDiscountPerRank = " + this.percentDiscountPerRank + " ";
      return local1 + "]";
    }
  }
}
