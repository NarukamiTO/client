package alternativa.tanks.model.presents {
  import alternativa.tanks.gui.presents.NewPresentsAlert;
  import alternativa.tanks.gui.presents.NewPresentsAlertEvent;
  import alternativa.tanks.service.notificationcategories.INotificationGarageCategoriesService;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.panel.model.presents.INewPresentsShowingModelBase;
  import projects.tanks.client.panel.model.presents.NewPresentsShowingModelBase;

  [ModelInfo]
  public class NewPresentsShowingModel extends NewPresentsShowingModelBase implements INewPresentsShowingModelBase {
    [Inject]
    public static var notificationGarageCategoriesService:INotificationGarageCategoriesService;

    public function NewPresentsShowingModel() {
      super();
    }

    public function showAlert() : void {
      var local1:NewPresentsAlert = new NewPresentsAlert();
      local1.addEventListener(NewPresentsAlertEvent.ACCEPT,getFunctionWrapper(this.accept));
      local1.addEventListener(NewPresentsAlertEvent.ACCEPT,getFunctionWrapper(this.cancel));
      notificationGarageCategoriesService.notifyAboutNewItemsInCategory(ItemViewCategoryEnum.GIVEN_PRESENTS);
    }

    private function cancel(param1:NewPresentsAlertEvent) : void {
      this.closeDialog(NewPresentsAlert(param1.target));
    }

    private function accept(param1:NewPresentsAlertEvent) : void {
      this.closeDialog(NewPresentsAlert(param1.target));
      server.showPresents();
    }

    private function closeDialog(param1:NewPresentsAlert) : void {
      param1.removeEventListener(NewPresentsAlertEvent.ACCEPT,getFunctionWrapper(this.accept));
      param1.removeEventListener(NewPresentsAlertEvent.CANCEL,getFunctionWrapper(this.cancel));
    }
  }
}
