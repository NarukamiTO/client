package alternativa.tanks.models.battle.gui.indicators {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.utils.removeDisplayObject;
  import controls.Label;
  import controls.statassets.BlackRoundRect;
  import flash.display.Bitmap;
  import flash.events.Event;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class TurnOverIndicator extends BlackRoundRect {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleGUIService:BattleGUIService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const turnOverIconClass:Class = TurnOverIndicator_turnOverIconClass;

    private var _show:Boolean;

    public function TurnOverIndicator() {
      var local8:int = 0;
      var local10:Label = null;
      var local11:Bitmap = null;
      super();
      var local1:String = localeService.getText(TanksLocale.TEXT_TURNOVER_HINT_1);
      var local2:String = localeService.getText(TanksLocale.TEXT_TURNOVER_HINT_2);
      var local3:int = 30;
      var local4:int = 30;
      var local5:int = 5;
      var local6:int = 16;
      var local7:Bitmap = new Bitmap(new turnOverIconClass().bitmapData);
      addChild(local7);
      local7.y = local3;
      local8 = local7.y + local7.height + 2 * local5;
      var local9:Label = new Label();
      local9.size = local6;
      local9.text = local1;
      local9.y = local8;
      addChild(local9);
      width = local9.textWidth;
      local8 += local9.height + local5;
      local10 = new Label();
      local10.size = local6;
      local10.text = local2;
      local10.y = local8;
      addChild(local10);
      if(width < local10.textWidth) {
        width = local10.textWidth;
      }
      local8 += local10.height + 2 * local5;
      local11 = new Bitmap(localeService.getImage(TanksLocale.IMAGE_TURNOVER_HINT_DELETE_BUTTON));
      local11.y = local8;
      addChild(local11);
      if(width < local11.width) {
        width = local11.width;
      }
      local8 += local11.height;
      width += 2 * local4;
      local7.x = width - local7.width >> 1;
      local11.x = width - local11.width >> 1;
      local9.x = width - local9.width >> 1;
      local10.x = width - local10.width >> 1;
      height = local8 + local3;
      this._show = false;
    }

    public function show() : void {
      if(this._show) {
        return;
      }
      this._show = true;
      battleGUIService.getViewportContainer().addChild(this);
      this.onResize();
      display.stage.addEventListener(Event.RESIZE,this.onResize);
    }

    public function hide() : void {
      if(!this._show) {
        return;
      }
      this._show = false;
      removeDisplayObject(this);
      display.stage.removeEventListener(Event.RESIZE,this.onResize);
    }

    private function onResize(param1:Event = null) : void {
      this.x = display.stage.stageWidth - this.width >> 1;
      this.y = display.stage.stageHeight - this.height >> 1;
    }

    public function destroy() : void {
      this.hide();
    }
  }
}
