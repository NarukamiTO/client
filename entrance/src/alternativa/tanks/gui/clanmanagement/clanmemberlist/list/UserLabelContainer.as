package alternativa.tanks.gui.clanmanagement.clanmemberlist.list {
  import base.DiscreteSprite;

  public class UserLabelContainer extends DiscreteSprite {
    private var _width:Number;
    private var _height:Number;

    public function UserLabelContainer() {
      super();
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
    }

    override public function get height() : Number {
      return this._height;
    }

    override public function set height(param1:Number) : void {
      this._height = param1;
    }
  }
}
