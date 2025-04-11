package alternativa.tanks.view.mainview.grouplist.header {
  import controls.base.LabelBase;
  import controls.statassets.StatLineHeader;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  public class GroupHeaderItem extends Sprite {
    private var bg:StatLineHeader = new StatLineHeader();
    private var label:LabelBase = new LabelBase();
    private var partOfHeader:int;

    public function GroupHeaderItem(param1:String, param2:int) {
      super();
      this.partOfHeader = param2;
      this.bg.width = width;
      this.bg.height = 18;
      addChild(this.bg);
      addChild(this.label);
      this.label.color = 860685;
      this.label.x = 2;
      this.label.y = 0;
      this.label.mouseEnabled = false;
      this.label.autoSize = TextFieldAutoSize.NONE;
      this.label.align = TextFormatAlign.LEFT;
      this.label.height = 18;
      this.label.text = param1;
    }

    override public function set width(param1:Number) : void {
      super.width = width;
      this.bg.width = param1;
      this.label.width = width - 4;
    }

    public function getPartOfHeader() : int {
      return this.partOfHeader;
    }
  }
}
