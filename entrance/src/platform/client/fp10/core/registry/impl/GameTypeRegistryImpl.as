package platform.client.fp10.core.registry.impl {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.registry.GameTypeRegistry;
  import platform.client.fp10.core.type.IGameClass;
  import platform.client.fp10.core.type.impl.GameClass;

  public class GameTypeRegistryImpl implements GameTypeRegistry {
    private var _classes:Dictionary;

    public function GameTypeRegistryImpl() {
      super();
      this._classes = new Dictionary();
    }

    public function createClass(param1:Long, param2:Vector.<Long>) : GameClass {
      var local3:GameClass = new GameClass(param1,param2);
      this._classes[param1] = local3;
      return local3;
    }

    public function destroyClass(param1:Long) : void {
      this._classes[param1] = null;
    }

    public function getClass(param1:Long) : IGameClass {
      return this._classes[param1];
    }

    public function get classes() : Dictionary {
      return this._classes;
    }
  }
}
