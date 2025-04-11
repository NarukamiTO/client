package alternativa.tanks.view.mainview.button {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.frames.YellowFrame;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class MainViewStarsEventButton extends MainViewButton {
    [Inject]
    public static var localeService:ILocaleService;

    private var url:String;

    public function MainViewStarsEventButton(param1:String, param2:String, param3:Bitmap, param4:int, param5:String) {
      var local6:Bitmap = Boolean(param3) ? param3 : new Bitmap(new BitmapData(166,106,true,2298478591));
      this.url = param5;
      super(param1,param2,local6,param4,new YellowFrame(100,FRAME_HEIGHT));
      button.setText(localeService.getText(TanksLocale.TEXT_OPEN_BATTLE_LIST_BUTTON));
    }

    override protected function onClick(param1:MouseEvent) : void {
      navigateToURL(new URLRequest(this.url));
    }

    override public function setSpectatorsButtonVisible(param1:Boolean) : void {
    }
  }
}
