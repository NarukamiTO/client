package alternativa.tanks.service.resistance {
  import alternativa.tanks.model.item.resistance.view.MountedResistancesPanel;
  import platform.client.fp10.core.type.IGameObject;

  public interface ResistanceService {
    function getView() : MountedResistancesPanel;
    function registerView(param1:MountedResistancesPanel) : void;
    function registerModel(param1:IGameObject) : void;
    function unregisterModel() : void;
    function unregisterView() : void;
    function mount(param1:int, param2:IGameObject) : void;
    function unmount(param1:IGameObject) : void;
    function isMounted(param1:IGameObject) : Boolean;
    function canBeMount(param1:IGameObject) : Boolean;
    function mountBought(param1:IGameObject) : void;
    function mountIntoFreeSlot(param1:IGameObject) : void;
    function setOnlyUnmountMode() : void;
  }
}
