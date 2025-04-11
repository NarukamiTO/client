package alternativa.tanks.model.garage.upgradingitems {
  import alternativa.tanks.service.upgradingitems.UpgradingItemsService;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;
  import projects.tanks.client.panel.model.garage.upgradingitems.IUpgradingItemsModelBase;
  import projects.tanks.client.panel.model.garage.upgradingitems.UpgradingItemsModelBase;

  [ModelInfo]
  public class UpgradingItemsModel extends UpgradingItemsModelBase implements IUpgradingItemsModelBase, UpgradingItem {
    [Inject]
    public static var upgradingItemsService:UpgradingItemsService;

    private var object:IGameObject;

    public function UpgradingItemsModel() {
      super();
    }

    public function init(param1:Vector.<GarageItemInfo>, param2:Vector.<GarageItemInfo>) : void {
      this.object = Model.object;
      upgradingItemsService.init(param1.concat(param2),this);
    }

    public function itemUpgraded(param1:IGameObject) : void {
      Model.object = this.object;
      server.itemUpgraded(param1);
      Model.popObject();
    }

    public function select(param1:IGameObject) : void {
      Model.object = this.object;
      server.select(param1);
      Model.popObject();
    }
  }
}
