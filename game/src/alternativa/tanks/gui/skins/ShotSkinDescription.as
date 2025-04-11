package alternativa.tanks.gui.skins {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.device.DevicesIcons;
  import alternativa.tanks.gui.device.list.DeviceBorder;
  import alternativa.tanks.model.item.skins.MountShotSkin;
  import alternativa.tanks.service.garage.GarageService;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.base.ThreeLineBigButton;
  import controls.labels.MouseDisabledLabel;
  import flash.display.Bitmap;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogEvent;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  public class ShotSkinDescription extends DiscreteSprite implements IImageResource {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var garageService:GarageService;

    private static const ICON_SIZE:int = 64;
    private static const DESCRIPTION_WIDTH:int = 200;

    private var icon:Bitmap = new Bitmap();

    public var buyButton:ThreeLineBigButton = new ThreeLineBigButton();
    public var mountButton:ThreeLineBigButton = new ThreeLineBigButton();

    private var border:DeviceBorder;
    private var iconResource:ImageResource;
    private var iconLoadListener:ImageResourceLoadingWrapper;

    public var skin:IGameObject;
    public var item:IGameObject;

    public function ShotSkinDescription(param1:IGameObject, param2:IGameObject) {
      super();
      this.item = param1;
      this.skin = param2;
      this.icon.x = 30;
      this.icon.y = 20;
      if(param2 == param1) {
        this.icon.bitmapData = DevicesIcons.iconDefaultShotColorBitmap;
      } else {
        this.iconResource = itemService.getPreviewResource(param2);
        if(Boolean(this.iconResource.isLazy) && !this.iconResource.isLoaded) {
          this.iconLoadListener = new ImageResourceLoadingWrapper(this);
          if(!this.iconResource.isLoading) {
            this.iconResource.loadLazyResource(this.iconLoadListener);
          } else {
            this.iconResource.addLazyListener(this.iconLoadListener);
          }
        } else {
          this.icon.bitmapData = this.iconResource.data;
        }
      }
      addChild(this.icon);
      var local3:MouseDisabledLabel = new MouseDisabledLabel();
      local3.size = 18;
      local3.color = ColorConstants.GREEN_TEXT;
      local3.width = DESCRIPTION_WIDTH;
      local3.wordWrap = true;
      local3.x = this.icon.x + ICON_SIZE + 10;
      local3.y = 20;
      local3.text = param2 == param1 ? localeService.getText(TanksLocale.TEXT_DEVICES_STANDARD_SETTINGS) : itemService.getName(param2);
      addChild(local3);
      var local4:MouseDisabledLabel = new MouseDisabledLabel();
      local4.color = ColorConstants.GREEN_TEXT;
      local4.multiline = true;
      local4.wordWrap = true;
      local4.width = DESCRIPTION_WIDTH;
      local4.x = local3.x;
      local4.y = local3.y + local3.height + 8;
      local4.text = param1 == param2 ? localeService.getText(TanksLocale.TEXT_DEVICES_STANDARD_SETTINGS_DESCRIPTION) : itemService.getDescription(param2);
      addChild(local4);
      this.border = new DeviceBorder(local4.y + local4.height + 20,true);
      this.border.x = 10;
      addChild(this.border);
      this.mountButton.x = this.border.x + this.border.width - this.mountButton.width - 20;
      this.mountButton.y = this.border.height - this.mountButton.height >> 1;
      addChild(this.mountButton);
      this.buyButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_BUY_TEXT));
      this.buyButton.x = this.mountButton.x;
      this.buyButton.y = this.mountButton.y;
      this.mountButton.addEventListener(MouseEvent.CLICK,this.onMount);
    }

    private function onBuy(param1:MouseEvent) : void {
      var local2:IGameObject = this.item.space.getObject(Long.getLong(214,886180036));
      garageService.getView().showItemInCategory(local2);
      dispatchEvent(new Event(DialogEvent.CLOSE));
    }

    private function onMount(param1:MouseEvent) : void {
      MountShotSkin(this.item.adapt(MountShotSkin)).mount(this.skin);
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function update() : void {
      var local1:Boolean = Boolean(itemService.hasItem(this.skin));
      var local2:Boolean = MountShotSkin(this.item.adapt(MountShotSkin)).getMountedSkin() == this.skin;
      this.buyButton.visible = !local1;
      this.mountButton.visible = local1;
      this.mountButton.enabled = !local2;
      this.mountButton.label = localeService.getText(local2 ? TanksLocale.TEXT_GARAGE_EQUIPPED_TEXT : TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_EQUIP_TEXT);
    }

    public function destroy() : void {
      if(this.iconLoadListener != null) {
        this.iconResource.removeLazyListener(this.iconLoadListener);
      }
    }

    public function setPreviewResource(param1:ImageResource) : void {
      this.icon.bitmapData = param1.data;
    }
  }
}
