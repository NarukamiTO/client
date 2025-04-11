package alternativa.tanks.gui.device {
  import alternativa.tanks.gui.crystalbutton.UpgradeSaleIcon;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class DeviceButton extends ShopButton {
    protected var _discountIcon:Bitmap = UpgradeSaleIcon.createInstance();
    protected var deviceImage:Bitmap;

    private var slot:int;

    public function DeviceButton(param1:int) {
      super(new DeviceButtonSkin());
      this.slot = param1;
      this.setUnclickable();
    }

    private function addSaleIcon() : void {
      addChildAt(this._discountIcon,3);
      this._discountIcon.x = 3;
      this._discountIcon.y = height - this._discountIcon.height - 3;
      this._discountIcon.visible = false;
    }

    public function setUnclickable() : void {
      this.setDevicesLockedIcon();
      buttonMode = false;
      super.removeEvents();
    }

    public function setClickable() : void {
      super.init();
    }

    public function setDeviceImage(param1:BitmapData) : void {
      if(this.deviceImage != null) {
        removeChild(this.deviceImage);
      }
      this.deviceImage = new Bitmap(param1);
      this.deviceImage.x = width - this.deviceImage.width >> 1;
      this.deviceImage.y = height - this.deviceImage.height >> 1;
      addChildAt(this.deviceImage,2);
    }

    public function setDevicesAvailableIcon() : void {
      this.setDeviceImage(this.getDefaultIcon(this.slot));
    }

    public function setDevicesLockedIcon() : void {
      this.setDeviceImage(DevicesIcons.lockedIcon);
    }

    public function setSale(param1:Boolean) : void {
      this._discountIcon.visible = param1;
    }

    private function getDefaultIcon(param1:int) : BitmapData {
      switch(param1) {
        case 0:
          return DevicesIcons.iconDefaultSkinBitmap;
        case 1:
          return DevicesIcons.iconDefaultDeviceBitmap;
        case 2:
          return DevicesIcons.iconDefaultShotColorBitmap;
        default:
          throw new Error("Invalid slot index " + param1);
      }
    }
  }
}
