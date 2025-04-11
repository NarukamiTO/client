package projects.tanks.client.panel.model.abonements {
  public class UserAbonementsCC {
    private var _abonementDataList:Vector.<ShopAbonementData>;

    public function UserAbonementsCC(param1:Vector.<ShopAbonementData> = null) {
      super();
      this._abonementDataList = param1;
    }

    public function get abonementDataList() : Vector.<ShopAbonementData> {
      return this._abonementDataList;
    }

    public function set abonementDataList(param1:Vector.<ShopAbonementData>) : void {
      this._abonementDataList = param1;
    }

    public function toString() : String {
      var local1:String = "UserAbonementsCC [";
      local1 += "abonementDataList = " + this.abonementDataList + " ";
      return local1 + "]";
    }
  }
}
