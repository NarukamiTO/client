package platform.client.fp10.core.type.impl {
  import alternativa.osgi.OSGi;
  import alternativa.types.Long;
  import flash.utils.getQualifiedClassName;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.*;

  public class GameClass implements IGameClass {
    private var _id:Long;
    private var _models:Vector.<Long>;

    public function GameClass(param1:Long, param2:Vector.<Long> = null) {
      super();
      this._id = param1;
      if(param2 != null) {
        this._models = param2;
      } else {
        this._models = new Vector.<Long>();
      }
    }

    public function get id() : Long {
      return this._id;
    }

    public function get models() : Vector.<Long> {
      return this._models;
    }

    public function toString() : String {
      var local3:int = 0;
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      var local2:String = "ClientClass\n";
      local2 += "  id: " + this._id + "\n";
      if(this._models.length > 0) {
        local2 += "  models:\n";
        local3 = 0;
        while(local3 < this._models.length) {
          local2 += "    id: " + this._models[local3] + ", class: " + getQualifiedClassName(local1.getModel(this._models[local3])) + "\n";
          local3++;
        }
      }
      return local2;
    }
  }
}
