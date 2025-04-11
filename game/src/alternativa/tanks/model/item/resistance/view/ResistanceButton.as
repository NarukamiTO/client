package alternativa.tanks.model.item.resistance.view {
  import alternativa.tanks.gui.device.DeviceButtonSkin;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.model.garage.resistance.ResistancesIconsUtils;
  import alternativa.tanks.model.item.properties.ItemPropertyValue;
  import alternativa.tanks.service.garage.GarageService;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.resistance.ResistanceService;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  public class ResistanceButton extends ShopButton {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var resistanceService:ResistanceService;

    [Inject]
    public static var garageService:GarageService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    private static const unmountHoverIconClass:Class = ResistanceButton_unmountHoverIconClass;
    private static const unmountHoverIcon:BitmapData = new unmountHoverIconClass().bitmapData;
    private static const mountHoverIconClass:Class = ResistanceButton_mountHoverIconClass;
    private static const mountHoverIcon:BitmapData = new mountHoverIconClass().bitmapData;
    private static const mountedBGIconClass:Class = ResistanceButton_mountedBGIconClass;
    private static const bgWithModule:BitmapData = new mountedBGIconClass().bitmapData;
    private static const freeBGIconClass:Class = ResistanceButton_freeBGIconClass;
    private static const freeBG:BitmapData = new freeBGIconClass().bitmapData;
    private static const lockedIconClass:Class = ResistanceButton_lockedIconClass;
    private static const lockedIcon:BitmapData = new lockedIconClass().bitmapData;

    private var buttonWithModule:Bitmap = new Bitmap(bgWithModule);
    private var freeButton:Bitmap = new Bitmap(freeBG);
    private var actionUnmount:Bitmap = new Bitmap(unmountHoverIcon);
    private var actionMount:Bitmap = new Bitmap(mountHoverIcon);

    public var item:IGameObject;

    private var index:int;

    protected var deviceImage:Bitmap;

    public function ResistanceButton(param1:int) {
      super(new DeviceButtonSkin());
      this.index = param1;
      this.buttonWithModule.visible = false;
      addChildAt(this.buttonWithModule,1);
      addChildAt(this.freeButton,2);
      this.actionUnmount.visible = false;
      this.actionUnmount.x = (width - this.actionUnmount.width) / 2;
      this.actionUnmount.y = (height - this.actionUnmount.height) / 2;
      this.actionMount.visible = false;
      this.actionMount.x = (width - this.actionMount.width) / 2;
      this.actionMount.y = (height - this.actionMount.height) / 2;
      addChildAt(this.actionUnmount,4);
      addChildAt(this.actionMount,5);
      this.enable();
    }

    public function getIndex() : int {
      return this.index;
    }

    public function disable() : void {
      buttonMode = false;
      super.removeEvents();
      this.removeEventListener(MouseEvent.CLICK,this.onClick);
      this.freeButton.bitmapData = lockedIcon;
    }

    public function enable() : void {
      super.init();
      this.addEventListener(MouseEvent.CLICK,this.onClick);
      this.freeButton.bitmapData = freeBG;
    }

    private function onWithoutHover() : void {
      this.actionMount.visible = false;
      this.actionUnmount.visible = false;
    }

    private function onHover() : void {
      this.actionUnmount.visible = !this.isFree();
      this.actionMount.visible = this.isFree();
    }

    private function updateBG() : void {
      this.buttonWithModule.visible = !this.isFree();
      this.freeButton.visible = this.isFree();
    }

    private function onClick(param1:MouseEvent) : void {
      var local2:IGameObject = null;
      if(this.item != null) {
        resistanceService.unmount(this.item);
      } else {
        local2 = garageService.getView().getSelectedItem();
        if(local2 != null) {
          if(!garageService.getView().isItemInStore(local2)) {
            resistanceService.mount(this.index,local2);
          }
        }
      }
    }

    override protected function onMouseEvent(param1:MouseEvent) : void {
      var local2:IGameObject = null;
      if(this.isFree()) {
        local2 = garageService.getView().getSelectedItem();
        if(local2 == null || Boolean(garageService.getView().isItemInStore(local2))) {
          this.disable();
          return;
        }
        this.enable();
      }
      overState.visible = param1.type == MouseEvent.MOUSE_OVER || param1.type == MouseEvent.MOUSE_DOWN;
      normalState.visible = !overState.visible;
      if(overState.visible) {
        this.onHover();
      } else {
        this.onWithoutHover();
        this.updateBG();
      }
    }

    public function reset() : void {
      if(this.item != null) {
        if(resistanceService.canBeMount(this.item)) {
          this.item = null;
          this.setResistanceImage(null);
          buttonMode = false;
        }
      }
    }

    public function isFree() : Boolean {
      return this.item == null;
    }

    private function setResistanceImage(param1:BitmapData) : void {
      if(this.deviceImage != null) {
        removeChild(this.deviceImage);
      }
      this.deviceImage = new Bitmap(param1);
      this.deviceImage.x = (width - this.deviceImage.width) / 2;
      this.deviceImage.y = (height - this.deviceImage.height) / 2;
      this.updateBG();
      addChildAt(this.deviceImage,3);
      buttonMode = true;
    }

    public function setDeviceImageFromItem(param1:IGameObject) : void {
      var local3:ItemPropertyValue = null;
      var local2:Vector.<ItemPropertyValue> = itemService.getProperties(param1);
      for each(local3 in local2) {
        this.setResistanceImage(ResistancesIconsUtils.getResistanceBigIcon(local3.getProperty()).bitmapData);
      }
    }

    override public function destroy() : void {
      this.removeEventListener(MouseEvent.CLICK,this.onClick);
      super.destroy();
    }
  }
}
