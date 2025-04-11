package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage {
  import alternativa.tanks.tracker.ITrackerService;
  import flash.events.EventDispatcher;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.tanksservices.model.logging.garage.GarageAction;

  public class UserGarageActionsServiceImpl extends EventDispatcher implements UserGarageActionsService {
    [Inject]
    public static var trackerService:ITrackerService;

    public function UserGarageActionsServiceImpl() {
      super();
    }

    public function selectItem(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.SELECT_ITEM,param1));
    }

    public function equipItem(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.EQUIP_ITEM,param1));
    }

    public function buyItem(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.BUY_ITEM,param1));
    }

    public function buyItemModification(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.BUY_MODIFICATION,param1));
    }

    public function upgradeItem(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.UPGRADE_ITEM,param1));
    }

    public function chooseItemCount(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.CHOOSE_COUNT,param1));
    }

    public function notEnoughCrystalsForBuying(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.SHOW_BUY_CRYSTALS_WINDOW,param1));
    }

    public function purchaseAccepted(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.PURCHASE_ACCEPTED,param1));
    }

    public function purchaseDeclined(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.PURCHASE_DECLINED,param1));
    }

    public function unmountItem(param1:IGameObject) : void {
      dispatchEvent(new UserGarageActionEvent(GarageAction.UNMOUNT_ITEM,param1));
    }
  }
}
