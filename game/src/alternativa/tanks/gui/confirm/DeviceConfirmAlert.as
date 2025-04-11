package alternativa.tanks.gui.confirm {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class DeviceConfirmAlert extends ConfirmAlert {
    private static const devicePlateBitmapClass:Class = DeviceConfirmAlert_devicePlateBitmapClass;
    private static const devicePlateBitmapData:BitmapData = new devicePlateBitmapClass().bitmapData;

    public function DeviceConfirmAlert(param1:IGameObject, param2:int) {
      super(param1,param2);
      var local3:Bitmap = new Bitmap(devicePlateBitmapData);
      local3.x = previewInner.x + (previewInner.width - devicePlateBitmapData.width >> 1);
      local3.y = previewInner.y + (previewInner.height - devicePlateBitmapData.height >> 1);
      addChildAt(local3,2);
    }

    override protected function getItemName(param1:IGameObject) : String {
      return localeService.getText(TanksLocale.TEXT_DEVICE);
    }
  }
}
