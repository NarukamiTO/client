package platform.client.fp10.core.type.impl {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameClass;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  public class NotLoadedGameObject implements IGameObject {
    private var _id:Long;
    private var _space:ISpace;

    public function NotLoadedGameObject(param1:Long, param2:ISpace) {
      super();
      this._id = param1;
      this._space = param2;
    }

    public function get id() : Long {
      return this._id;
    }

    public function get name() : String {
      throw new Error("Object not loaded, id = " + this._id);
    }

    public function get gameClass() : IGameClass {
      throw new Error("Object not loaded, id = " + this._id);
    }

    public function get space() : ISpace {
      return this._space;
    }

    public function hasModel(param1:Class) : Boolean {
      return false;
    }

    public function adapt(param1:Class) : Object {
      throw new Error("Object not loaded, id = " + this._id);
    }

    public function event(param1:Class) : Object {
      throw new Error("Object not loaded, id = " + this._id);
    }
  }
}
