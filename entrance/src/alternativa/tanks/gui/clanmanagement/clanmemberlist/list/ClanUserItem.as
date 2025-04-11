package alternativa.tanks.gui.clanmanagement.clanmemberlist.list {
  import alternativa.tanks.gui.icons.AcceptedIndicator;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import flash.display.Sprite;
  import flash.events.Event;
  import forms.ColorConstants;
  import forms.userlabel.UserLabel;

  public class ClanUserItem extends DiscreteSprite {
    protected static const MARGIN:int = 10;

    protected var _userLabel:UserLabel;
    protected var userContainer:Sprite;
    protected var _deleteIndicator:DeleteIndicator;
    protected var _acceptedIndicator:AcceptedIndicator;

    private var _width:Number = 1;
    private var _height:Number = 1;

    public function ClanUserItem() {
      super();
    }

    protected function onResize(param1:Event = null) : void {
    }

    protected function createUserLabel(param1:Long) : Sprite {
      var local2:UserLabelContainer = new UserLabelContainer();
      this._userLabel = new UserLabel(param1,false);
      this._userLabel.showClanProfile = false;
      this._userLabel.showInviteToClan = false;
      this._userLabel.x = -3;
      local2.addChild(this._userLabel);
      this._userLabel.setUidColor(ColorConstants.GREEN_LABEL);
      return local2;
    }

    protected function redrawBackground() : void {
      if(this.width <= 0) {
        return;
      }
      graphics.clear();
      graphics.beginFill(0,0);
      graphics.drawRect(0,0,this.width,20);
      graphics.endFill();
    }

    public function get deleteIndicator() : DeleteIndicator {
      return this._deleteIndicator;
    }

    public function get acceptedIndicator() : AcceptedIndicator {
      return this._acceptedIndicator;
    }

    public function isSelf() : Boolean {
      return this._userLabel.self;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.onResize();
    }

    override public function get height() : Number {
      return this._height;
    }

    override public function set height(param1:Number) : void {
      this._height = param1;
      this.onResize();
    }
  }
}
