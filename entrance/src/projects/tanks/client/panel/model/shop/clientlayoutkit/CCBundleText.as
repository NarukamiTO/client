package projects.tanks.client.panel.model.shop.clientlayoutkit {
  public class CCBundleText {
    private var _color:int;
    private var _fontPercentSize:int;
    private var _positionPercentX:int;
    private var _positionPercentY:int;
    private var _text:String;

    public function CCBundleText(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:String = null) {
      super();
      this._color = param1;
      this._fontPercentSize = param2;
      this._positionPercentX = param3;
      this._positionPercentY = param4;
      this._text = param5;
    }

    public function get color() : int {
      return this._color;
    }

    public function set color(param1:int) : void {
      this._color = param1;
    }

    public function get fontPercentSize() : int {
      return this._fontPercentSize;
    }

    public function set fontPercentSize(param1:int) : void {
      this._fontPercentSize = param1;
    }

    public function get positionPercentX() : int {
      return this._positionPercentX;
    }

    public function set positionPercentX(param1:int) : void {
      this._positionPercentX = param1;
    }

    public function get positionPercentY() : int {
      return this._positionPercentY;
    }

    public function set positionPercentY(param1:int) : void {
      this._positionPercentY = param1;
    }

    public function get text() : String {
      return this._text;
    }

    public function set text(param1:String) : void {
      this._text = param1;
    }

    public function toString() : String {
      var local1:String = "CCBundleText [";
      local1 += "color = " + this.color + " ";
      local1 += "fontPercentSize = " + this.fontPercentSize + " ";
      local1 += "positionPercentX = " + this.positionPercentX + " ";
      local1 += "positionPercentY = " + this.positionPercentY + " ";
      local1 += "text = " + this.text + " ";
      return local1 + "]";
    }
  }
}
