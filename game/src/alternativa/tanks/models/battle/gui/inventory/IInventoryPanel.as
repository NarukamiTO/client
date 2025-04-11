package alternativa.tanks.models.battle.gui.inventory {
  public interface IInventoryPanel {
    function assignItemToSlot(param1:InventoryItem, param2:int) : void;
    function itemUpdateCount(param1:InventoryItem) : void;
    function setVisible(param1:int, param2:Boolean, param3:Boolean) : void;
    function changeEffectTime(param1:int, param2:int, param3:Boolean, param4:Boolean) : void;
    function stopEffect(param1:int) : void;
    function activateCooldown(param1:int, param2:int) : void;
    function activateDependedCooldown(param1:int, param2:int) : void;
    function setCooldownDuration(param1:int, param2:int) : void;
    function ready(param1:int) : void;
    function showInventory() : void;
    function setEffectInfinite(param1:int, param2:Boolean) : void;
  }
}
