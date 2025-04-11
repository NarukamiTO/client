package alternativa.tanks.models.battle.gui.inventory {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.ControlMiniHelpCloseEvent;
  import alternativa.tanks.battle.events.InventoryItemActivationEvent;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.battlefield.models.inventory.item.IInventoryItemModelBase;
  import projects.tanks.client.battlefield.models.inventory.item.InventoryItemCC;
  import projects.tanks.client.battlefield.models.inventory.item.InventoryItemModelBase;

  [ModelInfo]
  public class InventoryItemModel extends InventoryItemModelBase implements IInventoryItemModelBase, ObjectUnloadListener, IInventoryItemActivator, ObjectLoadPostListener, IInventoryItem {
    [Inject]
    public static var inventoryPanel:IInventoryPanel;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var itemByObject:Dictionary = new Dictionary(true);

    public function InventoryItemModel() {
      super();
    }

    public function updateCount(param1:int) : void {
      var local2:InventoryItem = this.itemByObject[object];
      if(local2 != null) {
        if(local2.count <= 0 && param1 > 0) {
          inventoryPanel.showInventory();
          battleEventDispatcher.dispatchEvent(new ControlMiniHelpCloseEvent());
        }
        local2.count = param1;
        inventoryPanel.itemUpdateCount(local2);
      }
    }

    public function requestActivation(param1:InventoryItem) : void {
      battleEventDispatcher.dispatchEvent(new InventoryItemActivationEvent(param1));
    }

    public function doActivate(param1:InventoryItem, param2:Vector3) : void {
      Model.object = param1.getGameObject();
      battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.activate();
      Model.popObject();
    }

    public function objectLoadedPost() : void {
      var local1:InventoryItemCC = getInitParam();
      var local2:IInventoryPanel = inventoryPanel;
      var local3:InventoryItem = new InventoryItem(object,local1.itemIndex,local1.count,this);
      this.itemByObject[object] = local3;
      local2.assignItemToSlot(local3,this.getSlotIndex());
    }

    public function getSlotIndex() : int {
      return getInitParam().itemIndex;
    }

    public function objectUnloaded() : void {
      delete this.itemByObject[object];
    }
  }
}
