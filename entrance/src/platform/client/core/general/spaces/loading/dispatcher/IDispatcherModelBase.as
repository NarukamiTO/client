package platform.client.core.general.spaces.loading.dispatcher {
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsData;
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsDependencies;
  import platform.client.fp10.core.type.IGameObject;

  public interface IDispatcherModelBase {
    function loadDependencies(param1:ObjectsDependencies) : void;
    function loadObjectsData(param1:ObjectsData) : void;
    function unloadObjects(param1:Vector.<IGameObject>) : void;
  }
}
