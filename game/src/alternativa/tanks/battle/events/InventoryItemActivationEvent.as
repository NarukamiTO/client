package alternativa.tanks.battle.events {
  import alternativa.tanks.models.battle.gui.inventory.InventoryItem;

  public class InventoryItemActivationEvent {
    public var item:InventoryItem;

    public function InventoryItemActivationEvent(param1:InventoryItem) {
      super();
      this.item = param1;
    }
  }
}
