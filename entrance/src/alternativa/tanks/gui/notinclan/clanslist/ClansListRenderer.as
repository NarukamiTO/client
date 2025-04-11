package alternativa.tanks.gui.notinclan.clanslist {
  import controls.cellrenderer.CellNormal;
  import controls.cellrenderer.CellNormalSelected;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import forms.Styles;

  public class ClansListRenderer extends CellRenderer {
    private var clanInfoLabel:ClanInfoLabel;

    public function ClansListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      _data = param1;
      mouseEnabled = false;
      mouseChildren = true;
      buttonMode = useHandCursor = false;
      this.createLabels(_data);
      var local2:DisplayObject = new CellNormal();
      var local3:DisplayObject = new CellNormalSelected();
      setStyle(Styles.UP_SKIN,local2);
      setStyle(Styles.DOWN_SKIN,local2);
      setStyle(Styles.OVER_SKIN,local2);
      setStyle(Styles.SELECTED_UP_SKIN,local3);
      setStyle(Styles.SELECTED_OVER_SKIN,local3);
      setStyle(Styles.SELECTED_DOWN_SKIN,local3);
      this.clanInfoLabel.width = _width;
      addEventListener(Event.RESIZE,this.onResize,false,0,true);
      this.onResize();
    }

    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = _listData.label;
      if(this.clanInfoLabel != null) {
        setStyle("icon",this.clanInfoLabel);
      }
    }

    private function onResize(param1:Event = null) : void {
      this.clanInfoLabel.width = _width;
    }

    private function createLabels(param1:Object) : void {
      if(param1.type == ClanListType.INCOMING) {
        this.clanInfoLabel = new UserIncomingRequestLabel(param1.id);
      } else {
        this.clanInfoLabel = new UserOutgoingRequestLabel(param1.id);
      }
      addChild(this.clanInfoLabel);
    }

    public function onRollOut() : void {
      var local1:UserIncomingRequestLabel = null;
      super.selected = false;
      if(this.clanInfoLabel is UserIncomingRequestLabel) {
        local1 = UserIncomingRequestLabel(this.clanInfoLabel);
        if(local1.newIndicator != null) {
          local1.newIndicator.updateNotifications();
        }
      }
    }

    public function onRollOver() : void {
      var local1:UserIncomingRequestLabel = null;
      super.selected = true;
      if(this.clanInfoLabel is UserIncomingRequestLabel) {
        local1 = UserIncomingRequestLabel(this.clanInfoLabel);
        if(local1.newIndicator != null) {
          local1.newIndicator.visible = false;
        }
      }
    }
  }
}
