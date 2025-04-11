package projects.tanks.client.garage.models.item.modification {
  import alternativa.types.Long;

  public class ModificationCC {
    private var _baseItemId:Long;
    private var _modificationIndex:int;

    public function ModificationCC(param1:Long = null, param2:int = 0) {
      super();
      this._baseItemId = param1;
      this._modificationIndex = param2;
    }

    public function get baseItemId() : Long {
      return this._baseItemId;
    }

    public function set baseItemId(param1:Long) : void {
      this._baseItemId = param1;
    }

    public function get modificationIndex() : int {
      return this._modificationIndex;
    }

    public function set modificationIndex(param1:int) : void {
      this._modificationIndex = param1;
    }

    public function toString() : String {
      var local1:String = "ModificationCC [";
      local1 += "baseItemId = " + this.baseItemId + " ";
      local1 += "modificationIndex = " + this.modificationIndex + " ";
      return local1 + "]";
    }
  }
}
