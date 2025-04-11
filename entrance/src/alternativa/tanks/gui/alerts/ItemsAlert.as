package alternativa.tanks.gui.alerts {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.itemslist.PartsList;
  import alternativa.tanks.loader.IModalLoaderService;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.TankWindowWithHeader;
  import forms.events.PartsListEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class ItemsAlert extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    private var window:TankWindowWithHeader;
    private var inner:TankWindowInner;
    private var messageLabel:LabelBase;

    public var partsList:PartsList;

    private var closeButton:DefaultButtonBase;
    private var windowWidth:int = 350;
    private var windowHeight:int = 350;

    private const windowMargin:int = 12;
    private const space:int = 8;

    public function ItemsAlert(param1:String, param2:String, param3:Function, param4:Object) {
      super();
      this.partsList = new PartsList();
      this.partsList.height = 148;
      param3(param4);
      this.windowWidth = this.partsList.columnWidth * Math.min(3,this.partsList.itemsCount()) + this.windowMargin * 2 + this.space * 2;
      this.messageLabel = new LabelBase();
      this.messageLabel.width = this.windowWidth - this.windowMargin * 2 - this.space * 2;
      this.messageLabel.multiline = true;
      this.messageLabel.wordWrap = true;
      this.messageLabel.text = localeService.getText(param2);
      this.window = TankWindowWithHeader.createWindow(param1,this.windowWidth,this.windowHeight);
      addChild(this.window);
      this.inner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.inner);
      this.inner.x = this.windowMargin;
      this.inner.y = this.windowMargin;
      this.inner.width = this.windowWidth - this.windowMargin * 2;
      addChild(this.messageLabel);
      this.messageLabel.x = this.windowMargin + this.space;
      this.messageLabel.y = this.windowMargin + this.space;
      this.partsList.x = this.windowMargin + this.space;
      this.partsList.y = this.messageLabel.y + this.messageLabel.height + this.space;
      this.partsList.width = this.windowWidth - this.windowMargin * 2 - this.space * 2;
      addChild(this.partsList);
      this.closeButton = new DefaultButtonBase();
      addChild(this.closeButton);
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK);
      this.closeButton.x = this.windowWidth - this.closeButton.width >> 1;
      this.closeButton.y = this.partsList.y + this.partsList.height + this.space;
      this.windowHeight = this.messageLabel.height + this.partsList.height + this.closeButton.height + this.space * 4 + this.windowMargin * 2;
      this.window.height = this.windowHeight;
      this.inner.height = this.windowHeight - this.windowMargin * 3 - this.closeButton.height;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.closeWindow);
      this.partsList.addEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,this.onItemSelect);
      dialogService.enqueueDialog(this);
    }

    override protected function cancelKeyPressed() : void {
      this.closeWindow();
    }

    override protected function confirmationKeyPressed() : void {
      this.closeWindow();
    }

    private function closeWindow(param1:MouseEvent = null) : void {
      this.removeEventListenersAndRemoveDialog();
      dispatchEvent(new Event(Event.CANCEL));
    }

    private function removeEventListenersAndRemoveDialog() : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.closeWindow);
      this.partsList.removeEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,this.onItemSelect);
      dialogService.removeDialog(this);
    }

    private function onItemSelect(param1:PartsListEvent) : void {
      modalLoaderService.show();
      this.removeEventListenersAndRemoveDialog();
    }
  }
}
