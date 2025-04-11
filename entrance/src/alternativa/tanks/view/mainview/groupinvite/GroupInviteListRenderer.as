package alternativa.tanks.view.mainview.groupinvite {
  import alternativa.tanks.view.mainview.grouplist.item.GroupUserCellStyle;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.Styles;

  public class GroupInviteListRenderer extends CellRenderer {
    private var item:InviteUserItem;

    public function GroupInviteListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      _data = param1;
      mouseEnabled = false;
      mouseChildren = true;
      buttonMode = useHandCursor = false;
      var local2:Boolean = Boolean(data.online);
      var local3:DisplayObject = new GroupUserCellStyle(local2,false);
      var local4:DisplayObject = new GroupUserCellStyle(local2,local2);
      setStyle(Styles.UP_SKIN,local3);
      setStyle(Styles.DOWN_SKIN,local3);
      setStyle(Styles.OVER_SKIN,local3);
      setStyle(Styles.SELECTED_UP_SKIN,local4);
      setStyle(Styles.SELECTED_OVER_SKIN,local4);
      setStyle(Styles.SELECTED_DOWN_SKIN,local4);
      if(_data.id != null) {
        this.item = new InviteUserItem(_data);
        addChild(this.item);
      }
      addEventListener(Event.RESIZE,this.onResize,false,0,true);
      addEventListener(MouseEvent.ROLL_OVER,this.onRollOver,false,0,true);
      addEventListener(MouseEvent.ROLL_OUT,this.onRollOut,false,0,true);
      this.onResize();
    }

    protected function onResize(param1:Event = null) : void {
      if(this.item != null) {
        this.item.width = width;
      }
    }

    private function onRollOver(param1:MouseEvent) : void {
      if(this.item != null) {
        this.item.showAddIndicator();
        super.selected = true;
      }
    }

    private function onRollOut(param1:MouseEvent) : void {
      if(this.item != null) {
        this.item.hideAddIndicator();
        super.selected = false;
      }
    }

    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = _listData.label;
      if(this.item != null) {
        setStyle("icon",this.item);
      }
    }
  }
}
