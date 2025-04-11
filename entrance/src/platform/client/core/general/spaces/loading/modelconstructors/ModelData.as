package platform.client.core.general.spaces.loading.modelconstructors {
  import alternativa.types.Long;

  public class ModelData {
    private var _data:Object;
    private var _id:Long;

    public function ModelData(param1:Object = null, param2:Long = null) {
      super();
      this._data = param1;
      this._id = param2;
    }

    public function get data() : Object {
      return this._data;
    }

    public function set data(param1:Object) : void {
      this._data = param1;
    }

    public function get id() : Long {
      return this._id;
    }

    public function set id(param1:Long) : void {
      this._id = param1;
    }

    public function toString() : String {
      var local1:String = "ModelData [";
      local1 += "data = " + this.data + " ";
      local1 += "id = " + this.id + " ";
      return local1 + "]";
    }
  }
}
