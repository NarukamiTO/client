package projects.tanks.client.commons.models.runtime {
  import alternativa.types.Long;

  public class DataOwnerCC {
    private var _dataOwnerId:Long;

    public function DataOwnerCC(param1:Long = null) {
      super();
      this._dataOwnerId = param1;
    }

    public function get dataOwnerId() : Long {
      return this._dataOwnerId;
    }

    public function set dataOwnerId(param1:Long) : void {
      this._dataOwnerId = param1;
    }

    public function toString() : String {
      var local1:String = "DataOwnerCC [";
      local1 += "dataOwnerId = " + this.dataOwnerId + " ";
      return local1 + "]";
    }
  }
}
