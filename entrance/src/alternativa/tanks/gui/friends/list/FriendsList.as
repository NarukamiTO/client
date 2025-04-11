package alternativa.tanks.gui.friends.list {
  import alternativa.tanks.gui.friends.list.dataprovider.FriendsDataProvider;
  import alternativa.types.Long;
  import fl.controls.List;
  import flash.display.Sprite;
  import flash.utils.Dictionary;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import utils.ScrollStyleUtils;

  public class FriendsList extends Sprite {
    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    protected var _dataProvider:FriendsDataProvider;
    protected var _list:List;
    protected var _width:Number;
    protected var _height:Number;
    protected var _viewed:Dictionary;

    public function FriendsList() {
      super();
    }

    protected function init(param1:Object) : void {
      this._viewed = new Dictionary();
      this._list = new List();
      this._list.rowHeight = 20;
      this._list.setStyle("cellRenderer",param1);
      this._list.focusEnabled = true;
      this._list.selectable = false;
      ScrollStyleUtils.setGreenStyle(this._list);
      this._dataProvider = new FriendsDataProvider();
      this._list.dataProvider = this._dataProvider;
      addChild(this._list);
      ScrollStyleUtils.setGreenStyle(this._list);
    }

    protected function isViewed(param1:Object) : Boolean {
      return param1 in this._viewed;
    }

    protected function setAsViewed(param1:Object) : void {
      this._viewed[param1] = true;
    }

    protected function fillFriendsList(param1:FriendState) : void {
      var local3:Long = null;
      this._dataProvider.removeAll();
      this._dataProvider.resetFilter(false);
      var local2:Vector.<Long> = friendInfoService.getFriendsIdByState(param1);
      for each(local3 in local2) {
        this._dataProvider.addUser(local3,false);
      }
      this._dataProvider.refresh();
    }

    protected function filterByProperty(param1:String, param2:String) : void {
      this._dataProvider.setFilter(param1,param2);
      this.resize(this._width,this._height);
    }

    public function resize(param1:Number, param2:Number) : void {
      this._width = param1;
      this._height = param2;
      var local3:Boolean = this._list.verticalScrollBar.visible;
      this._list.width = local3 ? this._width + 6 : this._width;
      this._list.height = this._height;
    }
  }
}
