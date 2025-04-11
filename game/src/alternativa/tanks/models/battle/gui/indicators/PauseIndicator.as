package alternativa.tanks.models.battle.gui.indicators {
  import assets.IconAlarm;
  import controls.Label;
  import controls.statassets.BlackRoundRect;
  import flash.text.TextFieldAutoSize;

  public class PauseIndicator extends BlackRoundRect {
    private static const TIME_REPLACE_PATTERN:String = "{time}";

    private var timelLabel:Label;
    private var battleLeaveText:String;
    private var _seconds:int;

    public function PauseIndicator(param1:String, param2:String, param3:String) {
      var local10:Label = null;
      var local11:Label = null;
      super();
      this.battleLeaveText = param3;
      var local4:int = 33;
      var local5:int = 33;
      var local6:int = 5;
      var local7:int = 16;
      var local8:IconAlarm = new IconAlarm();
      addChild(local8);
      local8.y = local4;
      var local9:int = local8.y + local8.height + 2 * local6;
      local10 = new Label();
      local10.size = local7;
      local10.text = param1;
      local10.y = local9;
      addChild(local10);
      width = local10.textWidth;
      local9 += local10.height + local6;
      local11 = new Label();
      local11.size = local7;
      local11.text = param2;
      local11.y = local9;
      addChild(local11);
      if(width < local11.textWidth) {
        width = local11.textWidth;
      }
      local9 += local11.height + local6;
      this.timelLabel = new Label();
      this.timelLabel.size = local7;
      this.timelLabel.autoSize = TextFieldAutoSize.LEFT;
      this.timelLabel.text = param3 + " 99:99";
      this.timelLabel.y = local9;
      addChild(this.timelLabel);
      if(width < this.timelLabel.textWidth) {
        width = this.timelLabel.textWidth;
      }
      width += 2 * local5;
      local8.x = width - local8.width >> 1;
      local10.x = width - local10.width >> 1;
      local11.x = width - local11.width >> 1;
      height = local9 + this.timelLabel.height + local4 - 5;
    }

    public function set seconds(param1:int) : void {
      if(this._seconds == param1) {
        return;
      }
      this._seconds = param1;
      var local2:int = this._seconds / 60;
      this._seconds -= local2 * 60;
      var local3:String = this._seconds < 10 ? "0" + this._seconds : this._seconds.toString();
      this.timelLabel.text = this.battleLeaveText.replace(TIME_REPLACE_PATTERN,local2 + ":" + local3);
      this.timelLabel.x = width - this.timelLabel.width >> 1;
    }
  }
}
