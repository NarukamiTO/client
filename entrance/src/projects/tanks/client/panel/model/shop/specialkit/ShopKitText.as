package projects.tanks.client.panel.model.shop.specialkit {
  public class ShopKitText {
    private var _color:int;
    private var _size:int;
    private var _text:String;
    private var _x:int;
    private var _y:int;

    public function ShopKitText(param1:int = 0, param2:int = 0, param3:String = null, param4:int = 0, param5:int = 0) {
      super();
      this._color = param1;
      this._size = param2;
      this._text = param3;
      this._x = param4;
      this._y = param5;
    }

    public function get color() : int {
      return this._color;
    }

    public function set color(param1:int) : void {
      this._color = param1;
    }

    public function get size() : int {
      return this._size;
    }

    public function set size(param1:int) : void {
      this._size = param1;
    }

    public function get text() : String {
      return this._text;
    }

    public function set text(param1:String) : void {
      this._text = param1;
    }

    public function get x() : int {
      return this._x;
    }

    public function set x(param1:int) : void {
      this._x = param1;
    }

    public function get y() : int {
      return this._y;
    }

    public function set y(param1:int) : void {
      this._y = param1;
    }

    public function toString() : String {
      var local1:String = "ShopKitText [";
      local1 += "color = " + this.color + " ";
      local1 += "size = " + this.size + " ";
      local1 += "text = " + this.text + " ";
      local1 += "x = " + this.x + " ";
      local1 += "y = " + this.y + " ";
      return local1 + "]";
    }
  }
}
