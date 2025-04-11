package alternativa.tanks.models.battle.gui.inventory {
  import alternativa.math.Vector3;

  public interface IInventoryItemActivator {
    function requestActivation(param1:InventoryItem) : void;
    function doActivate(param1:InventoryItem, param2:Vector3) : void;
  }
}
