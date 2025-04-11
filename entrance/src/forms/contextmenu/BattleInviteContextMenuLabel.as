package forms.contextmenu {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class BattleInviteContextMenuLabel extends ContextMenuLabel {
    private static var battleInviteClass:Class = BattleInviteContextMenuLabel_battleInviteClass;

    public static var battleInviteBitmapData:BitmapData = Bitmap(new battleInviteClass()).bitmapData;

    private var _icon:Bitmap;

    public function BattleInviteContextMenuLabel() {
      super();
    }

    override protected function init() : void {
      this._icon = new Bitmap(battleInviteBitmapData);
      addChild(this._icon);
      this._icon.y = 4;
      super.init();
    }

    override public function set locked(param1:Boolean) : void {
      super.locked = param1;
      this.alignIcon();
    }

    private function alignIcon() : void {
      if(locked) {
        this._icon.x = 0;
        this._icon.visible = false;
      } else {
        this._icon.x = _label.width + 4;
        this._icon.visible = true;
      }
    }

    override public function get width() : Number {
      var local1:Number = NaN;
      if(locked) {
        local1 = _label.width;
      } else {
        local1 = this._icon.x + this._icon.width + 1;
      }
      return local1;
    }

    override public function set text(param1:String) : void {
      super.text = param1;
      this.alignIcon();
    }
  }
}
