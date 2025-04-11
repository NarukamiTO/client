package alternativa.tanks.battle.events {
  public class InventorySlotReadyToUseEvent {
    public var slotIndex:int;

    public function InventorySlotReadyToUseEvent(param1:int) {
      super();
      this.slotIndex = param1;
    }
  }
}
