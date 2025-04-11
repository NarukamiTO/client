package alternativa.tanks.gui.clanmanagement.clanmemberlist.members {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.ClanMembersDataProvider;
  import alternativa.tanks.models.clan.membersdata.ClanMembersDataService;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import fl.controls.List;
  import flash.events.Event;
  import flash.utils.Dictionary;
  import forms.Styles;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import utils.ScrollStyleUtils;

  public class ClanMembersList extends DiscreteSprite {
    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var clanMembersData:ClanMembersDataService;

    private var dataProvider:ClanMembersDataProvider = new ClanMembersDataProvider();
    private var list:List = new List();

    protected var viewed:Dictionary = new Dictionary();

    private var _width:int;
    private var _height:int;
    private var header:HeaderClanMemberList = new HeaderClanMemberList();

    public function ClanMembersList() {
      super();
      addChild(this.header);
      this.list.y = 20;
      this.list.rowHeight = 20;
      this.list.setStyle(Styles.CELL_RENDERER,ClanMembersListRenderer);
      this.list.focusEnabled = true;
      this.list.selectable = false;
      ScrollStyleUtils.setGreenStyle(this.list);
      this.dataProvider.getItemAtHandler = this.markAsViewed;
      this.list.dataProvider = this.dataProvider;
      addChild(this.list);
      ScrollStyleUtils.setGreenStyle(this.list);
      addEventListener(Event.ADDED_TO_STAGE,this.addResizeListener);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
    }

    private function markAsViewed(param1:Object) : void {
      if(!this.isViewed(param1)) {
        this.setAsViewed(param1);
      }
    }

    protected function setAsViewed(param1:Object) : void {
      this.viewed[param1] = true;
    }

    protected function isViewed(param1:Object) : Boolean {
      return param1 in this.viewed;
    }

    public function fillData(param1:Vector.<Object>) : void {
      var local2:Object = null;
      this.dataProvider.removeAll();
      for each(local2 in param1) {
        this.dataProvider.addItem(local2);
      }
      this.update();
    }

    private function sort() : void {
      this.dataProvider.sortOn(["permissionIndex","date"],[Array.NUMERIC,Array.NUMERIC | Array.DESCENDING]);
    }

    public function removeUser(param1:Long) : void {
      var local2:int = this.dataProvider.getItemIndexById(param1);
      if(local2 >= 0) {
        this.dataProvider.removeItemAt(local2);
      }
      this.update();
    }

    public function addUser(param1:Object) : void {
      this.dataProvider.addItem(param1);
      this.update(param1);
    }

    private function update(param1:Object = null) : void {
      if(param1 != null) {
        this.markAsViewed(param1);
      }
      this.sort();
      this.onResize();
    }

    private function addResizeListener(param1:Event) : void {
      stage.addEventListener(Event.RESIZE,this.onResize);
      this.onResize();
    }

    private function onResize(param1:Event = null) : void {
      this.list.height = this._height - 20;
      var local2:Boolean = this.list.maxVerticalScrollPosition > 0;
      this.header.width = this._width;
      this.list.width = local2 ? this._width + 8 : this._width;
    }

    private function onRemoveFromStage(param1:Event) : void {
      var local3:Object = null;
      stage.removeEventListener(Event.RESIZE,this.onResize);
      var local2:int = 0;
      while(local2 < this.dataProvider.length) {
        local3 = this.dataProvider.getItemAt(local2);
        local3.isNew = false;
        local2++;
      }
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
