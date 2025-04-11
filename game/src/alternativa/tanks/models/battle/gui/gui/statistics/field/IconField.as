package alternativa.tanks.models.battle.gui.gui.statistics.field {
  import assets.icons.BattleInfoIcons;
  import controls.Label;
  import flash.display.DisplayObject;
  import flash.display.Sprite;

  public class IconField extends Sprite {
    protected var icon:DisplayObject;
    protected var label:Label;

    public function IconField(param1:DisplayObject) {
      super();
      this.icon = param1;
      this.init();
    }

    public static function getIcon(param1:int) : DisplayObject {
      var local2:BattleInfoIcons = new BattleInfoIcons();
      local2.type = param1;
      return local2;
    }

    protected function init() : void {
      if(Boolean(this.icon)) {
        addChild(this.icon);
        this.icon.x = 0;
        this.icon.y = 0;
      }
      this.label = new Label();
      this.label.color = 16777215;
      if(Boolean(this.icon)) {
        this.label.x = this.icon.width + 3;
      }
      addChild(this.label);
    }

    public function set text(param1:String) : void {
      this.label.htmlText = param1;
    }

    public function set size(param1:Number) : void {
      this.label.size = param1;
    }
  }
}
