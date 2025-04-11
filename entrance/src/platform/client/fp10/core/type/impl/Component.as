package platform.client.fp10.core.type.impl {
  import platform.client.fp10.core.type.IGameObject;

  public class Component {
    private var _gameObject:IGameObject;

    public function Component() {
      super();
    }

    public function get gameObject() : IGameObject {
      return this._gameObject;
    }

    internal function setGameObject(param1:IGameObject) : void {
      this._gameObject = param1;
    }
  }
}
