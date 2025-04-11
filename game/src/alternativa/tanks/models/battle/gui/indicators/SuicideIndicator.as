package alternativa.tanks.models.battle.gui.indicators {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.utils.removeDisplayObject;
  import controls.base.LabelBase;
  import controls.statassets.BlackRoundRect;
  import flash.display.Bitmap;
  import flash.events.Event;
  import flash.text.TextFieldAutoSize;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class SuicideIndicator extends BlackRoundRect {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleGUIService:BattleGUIService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const reArmorIconClass:Class = SuicideIndicator_reArmorIconClass;
    private static const TIME_REPLACE_PATTERN:String = "{time}";

    private var _timeLabel:LabelBase;
    private var _throughText:String;
    private var _seconds:int;
    private var _isShow:Boolean;

    public function SuicideIndicator() {
      super();
      this.init();
    }

    private function init() : void {
      var local6:int = 0;
      this._throughText = localeService.getText(TanksLocale.TEXT_REARM_SELFDISTRUCTION);
      var local1:int = 33;
      var local2:int = 33;
      var local3:int = 5;
      var local4:int = 16;
      var local5:Bitmap = new Bitmap(new reArmorIconClass().bitmapData);
      addChild(local5);
      local5.y = local1 - 5;
      local6 = local5.y + local5.height + 2 * local3;
      this._timeLabel = new LabelBase();
      this._timeLabel.size = local4;
      this._timeLabel.autoSize = TextFieldAutoSize.LEFT;
      this._timeLabel.text = this._throughText.replace(TIME_REPLACE_PATTERN," 99:99");
      this._timeLabel.y = local6;
      addChild(this._timeLabel);
      if(width < this._timeLabel.textWidth) {
        width = this._timeLabel.textWidth;
      }
      width += 2 * local2;
      local5.x = width - local5.width >> 1;
      height = local6 + this._timeLabel.height + local1 - 5;
    }

    public function set seconds(param1:int) : void {
      if(this._seconds == param1) {
        return;
      }
      this._seconds = param1;
      var local2:int = this._seconds / 60;
      this._seconds -= local2 * 60;
      var local3:String = this._seconds < 10 ? "0" + this._seconds : this._seconds.toString();
      this._timeLabel.text = this._throughText.replace(TIME_REPLACE_PATTERN,local2 + ":" + local3);
      this._timeLabel.x = width - this._timeLabel.width >> 1;
    }

    public function show(param1:int) : void {
      if(this._isShow) {
        return;
      }
      this._isShow = true;
      this.seconds = param1;
      battleGUIService.getViewportContainer().addChild(this);
      this.onResize();
      display.stage.addEventListener(Event.RESIZE,this.onResize);
    }

    private function onResize(param1:Event = null) : void {
      this.x = display.stage.stageWidth - this.width >> 1;
      this.y = display.stage.stageHeight - this.height >> 1;
    }

    public function hide() : void {
      if(!this._isShow) {
        return;
      }
      this._isShow = false;
      removeDisplayObject(this);
      display.stage.removeEventListener(Event.RESIZE,this.onResize);
    }

    public function destroy() : void {
      this.hide();
      this._timeLabel = null;
    }
  }
}
