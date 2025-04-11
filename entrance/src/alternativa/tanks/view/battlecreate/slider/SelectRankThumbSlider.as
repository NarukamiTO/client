package alternativa.tanks.view.battlecreate.slider {
  import controls.slider.SliderThumb;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.geom.Matrix;
  import forms.ranks.SmallRankIcon;

  public class SelectRankThumbSlider extends SliderThumb {
    private static const bitmapArrow:Class = SelectRankThumbSlider_bitmapArrow;
    private static const arrow:BitmapData = new bitmapArrow().bitmapData;

    private var iconMin:SmallRankIcon;
    private var iconMax:SmallRankIcon;
    private var _minRang:int = 1;
    private var _maxRang:int = 1;

    public var leftDrag:Sprite;
    public var centerDrag:Sprite;
    public var rightDrag:Sprite;

    public function SelectRankThumbSlider() {
      var local1:Graphics = null;
      this.iconMin = new SmallRankIcon();
      this.iconMax = new SmallRankIcon();
      super();
      addChild(this.iconMax);
      addChild(this.iconMin);
      this.iconMin.y = this.iconMax.y = 9;
      this.leftDrag = new Sprite();
      local1 = this.leftDrag.graphics;
      local1.beginFill(0,0);
      local1.drawRect(0,0,15,30);
      local1.endFill();
      this.centerDrag = new Sprite();
      this.centerDrag.x = 15;
      this.rightDrag = new Sprite();
      local1 = this.rightDrag.graphics;
      local1.beginFill(0,0);
      local1.drawRect(0,0,15,30);
      local1.endFill();
      addChild(this.leftDrag);
      addChild(this.centerDrag);
      addChild(this.rightDrag);
      this.leftDrag.buttonMode = true;
      this.centerDrag.buttonMode = true;
      this.rightDrag.buttonMode = true;
    }

    override protected function draw() : void {
      var local2:Graphics = null;
      var local3:Matrix = null;
      super.draw();
      var local1:int = this._maxRang - this._minRang;
      this.iconMin.setDefaultAccount(this._minRang);
      this.iconMax.setDefaultAccount(this._maxRang);
      this.iconMax.visible = local1 > 0;
      if(local1 == 0) {
        this.iconMax.x = this.iconMin.x = int((_width - this.iconMin.width) / 2);
      } else {
        this.iconMin.x = 11;
        this.iconMax.x = _width - this.iconMax.width - 11;
        local2 = this.graphics;
        local3 = new Matrix();
        local3.translate(5,12);
        local2.beginBitmapFill(arrow,local3);
        local2.drawRect(5,12,4,7);
        local2.endFill();
        local3 = new Matrix();
        local3.rotate(Math.PI);
        local3.translate(_width - 9,12);
        local2.beginBitmapFill(arrow,local3);
        local2.drawRect(_width - 9,12,4,7);
        local2.endFill();
      }
      local2 = this.centerDrag.graphics;
      local2.clear();
      local2.beginFill(0,0);
      local2.drawRect(0,0,_width - 30,30);
      local2.endFill();
      this.rightDrag.x = _width - 15;
    }

    public function set minRang(param1:int) : void {
      this._minRang = param1;
      this.draw();
    }

    public function set maxRang(param1:int) : void {
      this._maxRang = param1;
      this.draw();
    }
  }
}
