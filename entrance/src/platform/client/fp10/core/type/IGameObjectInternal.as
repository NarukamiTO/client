package platform.client.fp10.core.type {
  import platform.client.fp10.core.model.impl.Model;

  public interface IGameObjectInternal extends IGameObject {
    function putData(param1:Model, param2:Class, param3:Object) : void;
    function getData(param1:Model, param2:Class) : Object;
    function clearData(param1:Model, param2:Class) : Object;
  }
}
