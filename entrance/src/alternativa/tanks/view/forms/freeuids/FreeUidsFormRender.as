package alternativa.tanks.view.forms.freeuids {
  import assets.combo.ComboListOverState;
  import controls.base.LabelBase;
  import flash.display.Sprite;

  public class FreeUidsFormRender extends Sprite {
    public static const HEIGHT:int = 20;
    public static const BGD_POS_X:int = 3;

    private var _uid:String;
    private var _index:int;
    private var _width:int;
    private var _backGround:ComboListOverState;

    public function FreeUidsFormRender(param1:int, param2:int, param3:String) {
      super();
      this._width = param1;
      this._index = param2;
      this._uid = param3;
      this.init();
    }

    private function init() : void {
      graphics.clear();
      graphics.beginFill(16711680,0);
      graphics.drawRect(0,0,this._width,HEIGHT);
      graphics.endFill();
      this._backGround = new ComboListOverState();
      this._backGround.width = this._width - BGD_POS_X * 2;
      this._backGround.height = HEIGHT;
      this._backGround.x = BGD_POS_X;
      addChild(this._backGround);
      var local1:LabelBase = new LabelBase();
      addChild(local1);
      local1.text = this._uid;
      local1.x = FreeUidsForm.LABEL_POS_X;
      this.setSelected(false);
    }

    public function setSelected(param1:Boolean) : void {
      this._backGround.visible = param1;
    }

    public function get index() : int {
      return this._index;
    }

    public function get uid() : String {
      return this._uid;
    }
  }
}
