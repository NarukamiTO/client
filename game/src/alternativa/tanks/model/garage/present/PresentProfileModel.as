package alternativa.tanks.model.garage.present {
  import alternativa.tanks.gui.GarageWindowEvent;
  import alternativa.tanks.gui.IGarageWindow;
  import alternativa.tanks.service.garage.GarageService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.impl.GameObject;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.garage.models.user.present.IPresentProfileModelBase;
  import projects.tanks.client.garage.models.user.present.PresentItem;
  import projects.tanks.client.garage.models.user.present.PresentProfileModelBase;

  [ModelInfo]
  public class PresentProfileModel extends PresentProfileModelBase implements IPresentProfileModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var garageService:GarageService;

    public function PresentProfileModel() {
      super();
    }

    public function objectLoaded() : void {
      var local2:PresentItem = null;
      var local3:GameObject = null;
      var local1:IGarageWindow = garageService.getView();
      for each(local2 in getInitParam().presents) {
        local3 = new GameObject(local2.id,null,"",object.space);
        local3.addComponent(new UserPresentComponent(local2));
        local1.addItemToDepot(local3);
      }
      local1.setCategoryButtonVisibility(ItemViewCategoryEnum.GIVEN_PRESENTS,getInitParam().presents.length > 0);
      local1.addEventListener(GarageWindowEvent.DELETE_PRESENT,getFunctionWrapper(this.onDeletePresentClick));
    }

    public function objectUnloaded() : void {
      var local1:IGarageWindow = garageService.getView();
      if(local1 != null) {
        local1.removeEventListener(GarageWindowEvent.DELETE_PRESENT,getFunctionWrapper(this.onDeletePresentClick));
      }
    }

    private function onDeletePresentClick(param1:GarageWindowEvent) : void {
      PresentGiven(object.adapt(PresentGiven)).removePresent(param1.item.id);
    }
  }
}
