package platform.client.core.general.spaces.loading.dispatcher.types {
  import platform.client.core.general.spaces.loading.modelconstructors.ModelData;
  import platform.client.fp10.core.type.IGameObject;

  public class ObjectsData {
    private var _modelsData:Vector.<ModelData>;
    private var _objects:Vector.<IGameObject>;

    public function ObjectsData(param1:Vector.<ModelData> = null, param2:Vector.<IGameObject> = null) {
      super();
      this._modelsData = param1;
      this._objects = param2;
    }

    public function get modelsData() : Vector.<ModelData> {
      return this._modelsData;
    }

    public function set modelsData(param1:Vector.<ModelData>) : void {
      this._modelsData = param1;
    }

    public function get objects() : Vector.<IGameObject> {
      return this._objects;
    }

    public function set objects(param1:Vector.<IGameObject>) : void {
      this._objects = param1;
    }

    public function toString() : String {
      var local1:String = "ObjectsData [";
      local1 += "modelsData = " + this.modelsData + " ";
      local1 += "objects = " + this.objects + " ";
      return local1 + "]";
    }
  }
}
