package alternativa.tanks.models.battle.gui.inventory.cooldown {
  import alternativa.tanks.models.battle.gui.inventory.IInventoryItem;
  import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.inventory.cooldown.DependedCooldownItem;
  import projects.tanks.client.battlefield.models.inventory.cooldown.IInventoryCooldownModelBase;
  import projects.tanks.client.battlefield.models.inventory.cooldown.InventoryCooldownModelBase;

  [ModelInfo]
  public class InventoryCooldownModel extends InventoryCooldownModelBase implements IInventoryCooldownModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var inventoryPanel:IInventoryPanel;

    private var slotIndexByObjectId:Dictionary = new Dictionary();

    public function InventoryCooldownModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function activateCooldown(param1:int) : void {
      inventoryPanel.activateCooldown(this.slotIndexByObjectId[object.id],param1);
    }

    [Obfuscation(rename="false")]
    public function activateDependentCooldown(param1:Vector.<DependedCooldownItem>) : void {
      var local4:DependedCooldownItem = null;
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3];
        inventoryPanel.activateDependedCooldown(this.slotIndexByObjectId[local4.id],local4.duration);
        local3++;
      }
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:IInventoryItem = IInventoryItem(object.adapt(IInventoryItem));
      this.slotIndexByObjectId[object.id] = int(local1.getSlotIndex());
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      delete this.slotIndexByObjectId[object.id];
    }

    [Obfuscation(rename="false")]
    public function setCooldownDuration(param1:int) : void {
      inventoryPanel.setCooldownDuration(this.slotIndexByObjectId[object.id],param1);
    }

    public function ready() : void {
      inventoryPanel.ready(this.slotIndexByObjectId[object.id]);
    }
  }
}
