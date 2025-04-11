package alternativa.tanks.models.battle.gui.inventory {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.type.IGameObject;

  public class InventoryItem {
    private var id:int;
    private var _count:int;
    private var gameObject:IGameObject;
    private var inventoryItemModel:IInventoryItemActivator;

    public function InventoryItem(param1:IGameObject, param2:int, param3:int, param4:IInventoryItemActivator) {
      super();
      this.gameObject = param1;
      this.id = param2;
      this._count = param3;
      this.inventoryItemModel = param4;
    }

    public function requestActivation() : void {
      this.inventoryItemModel.requestActivation(this);
    }

    public function doActivate(param1:Vector3) : void {
      this.inventoryItemModel.doActivate(this,param1);
    }

    public function getGameObject() : IGameObject {
      return this.gameObject;
    }

    public function getId() : int {
      return this.id;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function get count() : int {
      return this._count;
    }
  }
}
