package projects.tanks.client.panel.model.donationalert.types {
  import alternativa.types.Long;

  public class DonationData {
    private var _goods:Vector.<GoodInfoData>;
    private var _time:Long;

    public function DonationData(param1:Vector.<GoodInfoData> = null, param2:Long = null) {
      super();
      this._goods = param1;
      this._time = param2;
    }

    public function get goods() : Vector.<GoodInfoData> {
      return this._goods;
    }

    public function set goods(param1:Vector.<GoodInfoData>) : void {
      this._goods = param1;
    }

    public function get time() : Long {
      return this._time;
    }

    public function set time(param1:Long) : void {
      this._time = param1;
    }

    public function toString() : String {
      var local1:String = "DonationData [";
      local1 += "goods = " + this.goods + " ";
      local1 += "time = " + this.time + " ";
      return local1 + "]";
    }
  }
}
