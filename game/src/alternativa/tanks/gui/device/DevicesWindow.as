package alternativa.tanks.gui.device {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.device.DeviceService;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import alternativa.tanks.service.money.IMoneyService;
  import controls.base.DefaultButtonBase;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import forms.base.BaseFormWithInner;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import utils.ScrollStyleUtils;

  public class DevicesWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var moneyService:IMoneyService;

    [Inject]
    public static var propertyService:ItemPropertyParamsService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var dialogService:IDialogsService;

    [Inject]
    public static var deviceService:DeviceService;

    private static const WINDOW_WIDTH:int = 509;
    private static const WINDOW_HEIGHT:int = 450;
    private static const VERTICAL_MARGIN:int = 8;
    private static const HORIZONTAL_MARGIN:int = 12;
    private static const MIN_DEVICE_PANEL_HEIGHT:int = 110;

    private var baseForm:BaseFormWithInner = new BaseFormWithInner(WINDOW_WIDTH,WINDOW_HEIGHT,24);
    private var scrollContainer:Sprite = new Sprite();
    private var scrollPane:ScrollPane = new ScrollPane();
    private var closeButton:DefaultButtonBase = new DefaultButtonBase();
    private var devicePanels:Vector.<DevicePanel> = new Vector.<DevicePanel>();
    private var scrollPaneBottomPadding:Sprite = new Sprite();
    private var targetItem:IGameObject;
    private var deviceController:DeviceController;

    public function DevicesWindow(param1:IGameObject) {
      super();
      this.targetItem = param1;
      this.addWindow();
      this.addScrollPane();
      this.addCloseButton();
      this.addDevicePanels();
      this.deviceController = new DeviceController(this.devicePanels,param1);
      this.scrollPane.update();
      dialogService.addDialog(this);
    }

    private function addWindow() : void {
      this.baseForm.inner.showBlink = false;
      this.baseForm.window.setHeaderId(TanksLocale.TEXT_HEADER_DEVICES);
      this.baseForm.setHeight(WINDOW_HEIGHT);
      addChild(this.baseForm);
    }

    private function addScrollPane() : void {
      this.scrollPane.y = 10;
      ScrollStyleUtils.setGreenStyle(this.scrollPane);
      this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
      this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
      this.scrollPane.source = this.scrollContainer;
      this.scrollPane.focusEnabled = false;
      this.scrollPane.setSize(WINDOW_WIDTH,WINDOW_HEIGHT - 20);
      this.baseForm.inner.addChild(this.scrollPane);
    }

    private function addCloseButton() : void {
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_CLOSE_TEXT);
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onMouseClick);
      this.baseForm.window.addChild(this.closeButton);
    }

    private function addDevicePanels() : void {
      var local4:Number = NaN;
      var local1:Vector.<IGameObject> = this.getDevices(this.targetItem);
      var local2:int = 6;
      var local3:int = 0;
      while(local3 < local1.length) {
        local4 = Number(this.createDevicePanel(local1[local3],local2).height);
        local2 += Math.max(local4,MIN_DEVICE_PANEL_HEIGHT);
        local2 += 12;
        local3++;
      }
      this.fitToContent(local2);
    }

    private function getDevices(param1:IGameObject) : Vector.<IGameObject> {
      var local2:Vector.<IGameObject> = deviceService.getAvailableDevices(param1).concat();
      this.addDefaultDevice(local2);
      return local2;
    }

    private function addDefaultDevice(param1:Vector.<IGameObject>) : void {
      param1.unshift(null);
    }

    private function fitToContent(param1:int) : void {
      this.baseForm.setHeight(Math.min(param1 + 12,WINDOW_HEIGHT));
      this.fixScrollPaneBottomPadding(param1);
      this.alignCloseButton();
      dialogService.centerDialog(this);
    }

    private function fixScrollPaneBottomPadding(param1:int) : void {
      this.scrollPaneBottomPadding = new Sprite();
      this.scrollContainer.addChild(this.scrollPaneBottomPadding);
      this.scrollPaneBottomPadding.graphics.lineStyle(1,ColorConstants.WHITE,0);
      this.scrollPaneBottomPadding.graphics.beginFill(ColorConstants.WHITE,0);
      this.scrollPaneBottomPadding.graphics.drawRect(0,0,1,15);
      this.scrollPaneBottomPadding.graphics.endFill();
      this.scrollPaneBottomPadding.x = 0;
      this.scrollPaneBottomPadding.y = param1;
    }

    private function createDevicePanel(param1:IGameObject, param2:int) : DevicePanel {
      var local3:DevicePanel = new DevicePanel(this.targetItem,param1);
      local3.y = param2;
      this.scrollContainer.addChild(local3);
      this.devicePanels.push(local3);
      return local3;
    }

    private function alignCloseButton() : void {
      this.closeButton.y = this.baseForm.window.height - 5 - this.closeButton.height - VERTICAL_MARGIN;
      this.closeButton.x = this.baseForm.window.width - this.closeButton.width - HORIZONTAL_MARGIN;
    }

    private function onMouseClick(param1:MouseEvent) : void {
      this.onClose();
    }

    override protected function cancelKeyPressed() : void {
      this.onClose();
    }

    protected function onClose() : void {
      var local1:DevicePanel = null;
      this.deviceController.destroy();
      this.deviceController = null;
      this.removeEvents();
      for each(local1 in this.devicePanels) {
        local1.destroy();
      }
      dialogService.removeDialog(this);
    }

    protected function removeEvents() : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onClose);
    }

    override public function get width() : Number {
      return this.baseForm.window.width;
    }

    override public function get height() : Number {
      return this.baseForm.window.height;
    }
  }
}
