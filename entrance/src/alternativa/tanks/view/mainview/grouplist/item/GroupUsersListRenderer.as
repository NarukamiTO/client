package alternativa.tanks.view.mainview.grouplist.item {
  import alternativa.osgi.service.locale.ILocaleService;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.Styles;

  public class GroupUsersListRenderer extends CellRenderer {
    [Inject]
    public static var localeService:ILocaleService;

    private var item:GroupUserItem;

    public function GroupUsersListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      _data = param1;
      mouseEnabled = false;
      mouseChildren = true;
      buttonMode = useHandCursor = false;
      var local2:Boolean = Boolean(data.ready) || Boolean(data.isInviteSlot);
      var local3:DisplayObject = new GroupUserCellStyle(local2,false);
      var local4:DisplayObject = new GroupUserCellStyle(local2,true);
      setStyle(Styles.UP_SKIN,local3);
      setStyle(Styles.DOWN_SKIN,local3);
      setStyle(Styles.OVER_SKIN,local3);
      setStyle(Styles.SELECTED_UP_SKIN,local4);
      setStyle(Styles.SELECTED_OVER_SKIN,local4);
      setStyle(Styles.SELECTED_DOWN_SKIN,local4);
      if(_data.id != null || Boolean(_data.isInviteSlot)) {
        this.item = new GroupUserItem(_data);
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
        this.item.showDeleteIndicator();
        super.selected = true;
      }
    }

    private function onRollOut(param1:MouseEvent) : void {
      if(this.item != null) {
        this.item.hideDeleteIndicator();
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

    override public function set selected(param1:Boolean) : void {
    }
  }
}
