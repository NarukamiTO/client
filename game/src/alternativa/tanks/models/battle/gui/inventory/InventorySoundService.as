package alternativa.tanks.models.battle.gui.inventory {
  import platform.client.fp10.core.type.IGameObject;

  public interface InventorySoundService {
    function playActivationSound(param1:IGameObject, param2:int) : void;
    function playDeactivationSound(param1:int) : void;
    function playReadySound(param1:int) : void;
    function playNotReadySound() : void;
  }
}
