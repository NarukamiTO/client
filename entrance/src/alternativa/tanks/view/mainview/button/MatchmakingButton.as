package alternativa.tanks.view.mainview.button {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.battlelist.MatchmakingEvent;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class MatchmakingButton extends MainViewButton {
    [Inject]
    public static var localeService:ILocaleService;

    private var mode:MatchmakingMode;

    public function MatchmakingButton(param1:String, param2:String, param3:Bitmap, param4:MatchmakingMode, param5:int) {
      var local6:Bitmap = Boolean(param3) ? param3 : new Bitmap(new BitmapData(166,106,true,2298478591));
      super(localeService.getText(param1),localeService.getText(param2),local6,param5);
      this.mode = param4;
      button.setText(localeService.getText(TanksLocale.TEXT_PLAY_BUTTON));
    }

    override protected function onClick(param1:MouseEvent) : void {
      dispatchEvent(new MatchmakingEvent(MatchmakingEvent.REGISTRATION,this.mode));
    }

    override protected function onSpectatorClick(param1:MouseEvent) : void {
      dispatchEvent(new MatchmakingEvent(MatchmakingEvent.ENTER_AS_SPECTATOR,this.mode));
    }
  }
}
