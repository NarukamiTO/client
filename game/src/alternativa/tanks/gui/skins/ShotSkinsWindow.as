package alternativa.tanks.gui.skins {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.item.skins.AvailableShotSkins;
  import controls.base.DefaultButtonBase;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import forms.base.BaseFormWithInner;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import utils.ScrollStyleUtils;

  public class ShotSkinsWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var dialogService:IDialogsService;

    private static const WINDOW_WIDTH:int = 509;
    private static const WINDOW_HEIGHT:int = 450;
    private static const VERTICAL_MARGIN:int = 8;
    private static const HORIZONTAL_MARGIN:int = 12;
    private static const MIN_DEVICE_PANEL_HEIGHT:int = 110;

    private var baseForm:BaseFormWithInner = new BaseFormWithInner(WINDOW_WIDTH,WINDOW_HEIGHT,24);
    private var scrollContainer:Sprite = new Sprite();
    private var scrollPane:ScrollPane = new ScrollPane();
    private var closeButton:DefaultButtonBase = new DefaultButtonBase();
    private var descriptions:Vector.<ShotSkinDescription> = new Vector.<ShotSkinDescription>();
    private var scrollPaneBottomPadding:Sprite = new Sprite();
    private var item:IGameObject;
    private var onCloseCallback:Function;

    public function ShotSkinsWindow(param1:IGameObject, param2:Function) {
      super();
      this.item = param1;
      this.onCloseCallback = param2;
      this.addWindow();
      this.addScrollPane();
      this.addCloseButton();
      this.addSkinsPanel();
      this.scrollPane.update();
      dialogService.addDialog(this);
      this.updateAll(null);
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

    private function addSkinsPanel() : void {
      var local4:Number = NaN;
      var local1:Vector.<IGameObject> = AvailableShotSkins(this.item.adapt(AvailableShotSkins)).getSkins();
      var local2:int = 6;
      local2 += Math.max(this.createSkinDescription(this.item,local2).height,MIN_DEVICE_PANEL_HEIGHT) + 12;
      var local3:int = 0;
      while(local3 < local1.length) {
        local4 = Number(this.createSkinDescription(local1[local3],local2).height);
        local2 += Math.max(local4,MIN_DEVICE_PANEL_HEIGHT);
        local2 += 12;
        local3++;
      }
      this.fitToContent(local2);
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

    private function createSkinDescription(param1:IGameObject, param2:int) : ShotSkinDescription {
      var local3:ShotSkinDescription = new ShotSkinDescription(this.item,param1);
      local3.y = param2;
      this.scrollContainer.addChild(local3);
      this.descriptions.push(local3);
      local3.addEventListener(Event.CHANGE,this.updateAll);
      return local3;
    }

    private function updateAll(param1:Event) : void {
      var local2:ShotSkinDescription = null;
      for each(local2 in this.descriptions) {
        local2.update();
      }
      if(param1 != null) {
        dispatchEvent(param1);
      }
    }

    private function alignCloseButton() : void {
      this.closeButton.y = this.baseForm.window.height - 5 - this.closeButton.height - VERTICAL_MARGIN;
      this.closeButton.x = this.baseForm.window.width - this.closeButton.width - HORIZONTAL_MARGIN;
    }

    private function onMouseClick(param1:MouseEvent) : void {
      this.close();
    }

    override protected function cancelKeyPressed() : void {
      this.close();
    }

    public function close() : void {
      var local1:ShotSkinDescription = null;
      this.removeEvents();
      for each(local1 in this.descriptions) {
        local1.destroy();
      }
      dialogService.removeDialog(this);
      this.onCloseCallback();
    }

    protected function removeEvents() : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
    }

    override public function get width() : Number {
      return this.baseForm.window.width;
    }

    override public function get height() : Number {
      return this.baseForm.window.height;
    }
  }
}
