package alternativa.tanks.model.garage.present {
  import alternativa.tanks.gui.present.give.CheckUidEvent;
  import alternativa.tanks.gui.present.give.PresentPrepareWindow;
  import alternativa.tanks.gui.present.give.SendPresentEvent;
  import alternativa.tanks.model.garage.GaragePurchaseConfirmation;
  import alternativa.tanks.service.item.ItemService;
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.garage.present.IPresentPurchaseModelBase;
  import projects.tanks.client.garage.models.garage.present.PresentPurchaseModelBase;

  [ModelInfo]
  public class PresentPurchaseModel extends PresentPurchaseModelBase implements IPresentPurchaseModelBase, PresentPurchase {
    [Inject]
    public static var itemService:ItemService;

    private var uid:String;
    private var text:String;
    private var price:int;
    private var presentPrepareWindow:PresentPrepareWindow;
    private var presentItem:IGameObject;

    public function PresentPurchaseModel() {
      super();
    }

    public function preparePresent(param1:IGameObject) : void {
      this.presentItem = param1;
      this.presentPrepareWindow = new PresentPrepareWindow();
      this.presentPrepareWindow.addEventListener(SendPresentEvent.SEND_PRESENT,getFunctionWrapper(this.onSendPresent));
      this.presentPrepareWindow.addEventListener(Event.CANCEL,getFunctionWrapper(this.onCancelPresentPrepareWindow));
      this.presentPrepareWindow.addEventListener(CheckUidEvent.CHECK_UID,getFunctionWrapper(this.checkUid));
    }

    private function onCancelPresentPrepareWindow(param1:Event) : void {
      this.onClosePresentPrepareWindow();
    }

    private function onClosePresentPrepareWindow() : void {
      this.presentPrepareWindow.removeEventListener(SendPresentEvent.SEND_PRESENT,getFunctionWrapper(this.onSendPresent));
      this.presentPrepareWindow.removeEventListener(Event.CANCEL,getFunctionWrapper(this.onClosePresentPrepareWindow));
      this.presentPrepareWindow.removeEventListener(CheckUidEvent.CHECK_UID,getFunctionWrapper(this.checkUid));
      this.presentPrepareWindow = null;
    }

    private function onSendPresent(param1:SendPresentEvent) : void {
      this.uid = param1.uid;
      this.text = param1.text;
      this.price = itemService.getPrice(this.presentItem);
      this.onClosePresentPrepareWindow();
      GaragePurchaseConfirmation(object.adapt(GaragePurchaseConfirmation)).showConfirmationAlert(this.price);
    }

    public function confirmPresentPurchase(param1:IGameObject) : void {
      server.purchasePresent(this.uid,param1,this.text,this.price);
    }

    public function setUidAvailable(param1:Boolean) : void {
      this.presentPrepareWindow.setUidAvailable(param1);
    }

    private function checkUid(param1:CheckUidEvent) : void {
      server.checkUid(param1.uid);
    }
  }
}
