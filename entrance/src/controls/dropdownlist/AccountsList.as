package controls.dropdownlist {
  import controls.base.TankInputBase;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.net.SharedObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class AccountsList extends DropDownList {
    [Inject]
    public static var storageService:IStorageService;

    public static const ROW_HEIGHT:int = 20;

    private var dropButton:DropDownButton = new DropDownButton();
    private var inputControl:TankInputBase;

    public function AccountsList(param1:TankInputBase) {
      super();
      this.inputControl = param1;
      this.inputControl.addEventListener(Event.ADDED,this.onAdded);
    }

    private function onAdded(param1:Event) : void {
      this.inputControl.removeEventListener(Event.ADDED,this.onAdded);
      this.listBg.x = this.inputControl.x;
      this.listBg.y = this.inputControl.y + 28;
      this.inputControl.parent.addChildAt(this.listBg,this.inputControl.parent.getChildIndex(this.inputControl));
    }

    override protected function init() : void {
      super.init();
      list.y = 30;
      list.height = 100;
      list.rowHeight = ROW_HEIGHT;
      this.listBg.height = 110;
      removeChild(button);
      addChild(this.dropButton);
      this.dropButton.y = -1;
      this.dropButton.addEventListener(MouseEvent.CLICK,onButtonClick);
      setRenderer(AccountsRenderer);
      addEventListener(DeleteEvent.REMOVED,this.onAccountRemove);
    }

    public function onAccountRemove(param1:DeleteEvent) : void {
      list.removeItem(param1.data);
      close();
      selectedItem = null;
      height = Math.min(this.length,4) * ROW_HEIGHT + 13;
      var local2:Object = param1.data.data;
      var local3:SharedObject = storageService.getAccountsStorage();
      delete local3.data[local2.userName];
      dispatchEvent(new Event(Event.CHANGE));
    }

    override protected function get listBg() : DPLBackground {
      if(!_listBg) {
        _listBg = new AccountsBackground();
      }
      return _listBg;
    }

    override public function addItem(param1:Object) : void {
      super.addItem(param1);
      height = Math.min(this.length,4) * ROW_HEIGHT + 10;
    }

    override public function set width(param1:Number) : void {
      this.dropButton.x = param1 - 30;
      super.width = param1;
    }

    override protected function draw() : void {
      super.draw();
      list.setSize(this.listBg.width,this.listBg.height - 7);
      list.invalidate();
    }

    public function get length() : Number {
      return dp.length;
    }

    public function initialize() : void {
      var local3:String = null;
      var local4:SharedObject = null;
      clear();
      var local1:SharedObject = storageService.getAccountsStorage();
      var local2:int = 0;
      for(local3 in local1.data) {
        if(Boolean(local1.data[local3].userHash)) {
          this.addItem({
            "gameName":local3,
            "rang":0,
            "id":local2++,
            "data":local1.data[local3]
          });
        }
      }
      visible = local2 > 0;
      local4 = storageService.getStorage();
      if(Boolean(local4.data.userName)) {
        selectItemByField("gameName",local4.data.userName);
      } else {
        selectItemByField("id",0);
      }
    }
  }
}
