package alternativa.tanks.gui.error {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankWindow;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.events.TextEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.text.TextFieldAutoSize;
  import platform.client.fp10.core.service.address.AddressService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class ErrorForm extends DialogWindow {
    [Inject]
    public static var addressService:AddressService;

    private static const IconImage:Class = ErrorForm_IconImage;
    private static const iconImage:BitmapData = new IconImage().bitmapData;

    private var localeService:ILocaleService;
    private var _refreshButton:DefaultButtonBase;
    private var _supportLink:LabelBase;
    private var window:TankWindow;
    private var description:LabelBase;
    private var field:TankWindowInner;
    private var icon:Bitmap;
    private var SUPPORT_URL:String;

    public function ErrorForm(param1:ILocaleService) {
      var local3:Number = NaN;
      var local5:Number = NaN;
      super();
      this.localeService = param1;
      var local2:Number = 300;
      local3 = 12;
      var local4:Number = 10;
      local5 = -2;
      var local6:Number = 47;
      var local7:Number = 33;
      var local8:Number = 100;
      this.icon = new Bitmap(iconImage);
      this.icon.x = 23;
      this.icon.y = 23;
      this.description = new LabelBase();
      this.description.color = 5898035;
      this.description.multiline = true;
      this.description.autoSize = TextFieldAutoSize.LEFT;
      this.description.x = this.icon.x + this.icon.width + local3 - 4;
      this.description.y = local3 + local3 - 3;
      this.description.text = "Unknown";
      this.description.selectable = true;
      if(this.description.y + this.description.height > this.icon.y + this.icon.height) {
        local6 += this.description.y + this.description.height - this.icon.y - this.icon.height;
      }
      this.window = new TankWindow(local2,local3 + local6 + local4 + local7 + local4 + local5 + local7 + local3);
      this.field = new TankWindowInner(local2 - local3 * 2,local6,TankWindowInner.GREEN);
      this.field.x = local3;
      this.field.y = local3;
      addChild(this.window);
      this.window.addChild(this.field);
      this.window.addChild(this.icon);
      this.window.addChild(this.description);
      this._refreshButton = new DefaultButtonBase();
      this._refreshButton.label = param1.getText(TanksLocale.TEXT_REENTER_TO_GAME);
      this._refreshButton.x = local3 + 1;
      this._refreshButton.y = local3 + local6 + local4;
      this._refreshButton.width += 24 * 2;
      this._refreshButton.addEventListener(MouseEvent.CLICK,this.onRefreshButtonClick);
      this.window.addChild(this._refreshButton);
      this._supportLink = new LabelBase();
      this._supportLink.htmlText = "<a href=\'event:haveAcc\'><font color=\'#31FE01\'><u>" + param1.getText(TanksLocale.TEXT_CAUSES_AND_SOLUTIONS) + "</u></font></a>";
      this._supportLink.x = local2 - local3 - local8 - 1;
      this._supportLink.y = local3 + local6 + local4 + local7 + local4 + local5;
      this._supportLink.addEventListener(TextEvent.LINK,this.onSupportClick);
      this.window.addChild(this._supportLink);
      this.reposition();
    }

    private function reposition() : void {
      this.window.x = display.stage.width - this.window.width >> 1;
      this.window.y = display.stage.height - this.window.height >> 1;
    }

    private function onSupportClick(param1:TextEvent) : void {
      navigateToURL(new URLRequest(this.SUPPORT_URL),"_blank");
    }

    private function onRefreshButtonClick(param1:MouseEvent = null) : void {
      if(addressService != null) {
        addressService.reload();
      }
    }

    private function redraw() : void {
      this.field.width = 12 + this.icon.width + 8 + this.description.width + 20;
      this.field.height = Math.max(this.icon.height,this.description.height) + 2 * 10;
      this.window.width = this.field.width + 2 * 12;
      this.window.height = 12 + this.field.height + 12 + this._refreshButton.height + 12 + this._supportLink.height + 14 - 10;
      if(this.description.height < this.icon.height) {
        this.description.y = this.icon.y + (this.icon.height - this.description.textHeight >> 1) - 3;
      }
      this._refreshButton.x = this.window.width - this._refreshButton.width >> 1;
      this._refreshButton.y = this.field.y + this.field.height + 12 - 4;
      this._supportLink.x = this.window.width - this._supportLink.width >> 1;
      this._supportLink.y = this._refreshButton.y + this._refreshButton.height + 12 - 7;
      this.reposition();
    }

    public function setErrorText(param1:String) : void {
      this.description.text = param1;
      this.redraw();
    }

    public function setSupportUrl(param1:String) : void {
      this.SUPPORT_URL = param1;
    }
  }
}
