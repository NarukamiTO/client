package projects.tanks.client.garage.models.item.rarity {
  public class ItemRarityCC {
    private var _rarity:Rarity;

    public function ItemRarityCC(param1:Rarity = null) {
      super();
      this._rarity = param1;
    }

    public function get rarity() : Rarity {
      return this._rarity;
    }

    public function set rarity(param1:Rarity) : void {
      this._rarity = param1;
    }

    public function toString() : String {
      var local1:String = "ItemRarityCC [";
      local1 += "rarity = " + this.rarity + " ";
      return local1 + "]";
    }
  }
}
