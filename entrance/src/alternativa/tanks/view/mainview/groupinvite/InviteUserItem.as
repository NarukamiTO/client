package alternativa.tanks.view.mainview.groupinvite {
  import alternativa.tanks.gui.icons.AcceptedIndicator;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import forms.userlabel.UserLabel;

  public class InviteUserItem extends Sprite {
    private var itemWidth:Number = 0;
    private var inviteIndicator:AcceptedIndicator;
    private var userLabel:UserLabel;

    public function InviteUserItem(param1:Object) {
      super();
      this.userLabel = new UserLabel(param1.id,false);
      this.userLabel.mouseEnabled = false;
      this.userLabel.x = -4;
      this.userLabel.y = 1;
      this.userLabel.setUidColor(Boolean(param1.online) ? ColorConstants.GREEN_LABEL : ColorConstants.ACCESS_LABEL,true);
      if(Boolean(param1.online)) {
        this.inviteIndicator = new AcceptedIndicator();
        this.inviteIndicator.y = 1;
        this.inviteIndicator.visible = false;
        this.inviteIndicator.addEventListener(MouseEvent.CLICK,this.onClick);
        addChild(this.inviteIndicator);
      }
      addChild(this.userLabel);
    }

    private function onClick(param1:MouseEvent) : void {
      this.inviteIndicator.visible = false;
      dispatchEvent(new InviteUserEvent(this.userLabel.userId));
    }

    override public function get width() : Number {
      return this.itemWidth;
    }

    override public function set width(param1:Number) : void {
      this.itemWidth = param1;
      this.resize();
    }

    private function resize() : void {
      if(this.inviteIndicator != null) {
        this.inviteIndicator.x = this.width - this.inviteIndicator.width - 7;
      }
      this.redraw();
    }

    private function redraw() : void {
      graphics.clear();
      graphics.beginFill(0,0);
      graphics.drawRect(0,0,this.width,20);
      graphics.endFill();
    }

    public function showAddIndicator() : void {
      if(this.inviteIndicator != null) {
        this.inviteIndicator.visible = true;
      }
    }

    public function hideAddIndicator() : void {
      if(this.inviteIndicator != null) {
        this.inviteIndicator.visible = false;
      }
    }
  }
}
