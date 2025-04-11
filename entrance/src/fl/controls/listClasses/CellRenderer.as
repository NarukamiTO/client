package fl.controls.listClasses {
  import fl.controls.LabelButton;
  import flash.events.MouseEvent;

  [Style(name="textPadding",type="Number",format="Length")]
  [Style(name="disabledTextFormat",type="flash.text.TextFormat")]
  [Style(name="textFormat",type="flash.text.TextFormat")]
  [Style(name="selectedOverSkin",type="Class")]
  [Style(name="selectedDownSkin",type="Class")]
  [Style(name="selectedUpSkin",type="Class")]
  [Style(name="selectedDisabledSkin",type="Class")]
  [Style(name="disabledSkin",type="Class")]
  [Style(name="overSkin",type="Class")]
  [Style(name="downSkin",type="Class")]
  [Style(name="upSkin",type="Class")]
  public class CellRenderer extends LabelButton implements ICellRenderer {
    private static var defaultStyles:Object = {
      "upSkin":"CellRenderer_upSkin",
      "downSkin":"CellRenderer_downSkin",
      "overSkin":"CellRenderer_overSkin",
      "disabledSkin":"CellRenderer_disabledSkin",
      "selectedDisabledSkin":"CellRenderer_selectedDisabledSkin",
      "selectedUpSkin":"CellRenderer_selectedUpSkin",
      "selectedDownSkin":"CellRenderer_selectedDownSkin",
      "selectedOverSkin":"CellRenderer_selectedOverSkin",
      "textFormat":null,
      "disabledTextFormat":null,
      "embedFonts":null,
      "textPadding":5
    };

    protected var _listData:ListData;
    protected var _data:Object;

    public function CellRenderer() {
      super();
      toggle = true;
      focusEnabled = false;
    }

    public static function getStyleDefinition() : Object {
      return defaultStyles;
    }

    override public function set selected(param1:Boolean) : void {
      super.selected = param1;
    }

    override protected function drawLayout() : void {
      var local3:Number = NaN;
      var local1:Number = Number(getStyleValue("textPadding"));
      var local2:Number = 0;
      if(icon != null) {
        icon.x = local1;
        icon.y = Math.round(height - icon.height >> 1);
        local2 = icon.width + local1;
      }
      if(label.length > 0) {
        textField.visible = true;
        local3 = Math.max(0,width - local2 - local1 * 2);
        textField.width = local3;
        textField.height = textField.textHeight + 4;
        textField.x = local2 + local1;
        textField.y = Math.round(height - textField.height >> 1);
      } else {
        textField.visible = false;
      }
      background.width = width;
      background.height = height;
    }

    public function get listData() : ListData {
      return _listData;
    }

    override public function setSize(param1:Number, param2:Number) : void {
      super.setSize(param1,param2);
    }

    public function get data() : Object {
      return _data;
    }

    public function set data(param1:Object) : void {
      _data = param1;
    }

    public function set listData(param1:ListData) : void {
      _listData = param1;
      label = _listData.label;
      setStyle("icon",_listData.icon);
    }

    override public function get selected() : Boolean {
      return super.selected;
    }

    override protected function toggleSelected(param1:MouseEvent) : void {
    }
  }
}
