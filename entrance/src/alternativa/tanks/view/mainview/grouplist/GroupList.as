package alternativa.tanks.view.mainview.grouplist {
  import alternativa.tanks.view.mainview.grouplist.header.GroupHeader;
  import alternativa.tanks.view.mainview.grouplist.item.GroupUsersDataProvider;
  import alternativa.tanks.view.mainview.grouplist.item.GroupUsersListRenderer;
  import alternativa.types.Long;
  import controls.dropdownlist.DeleteEvent;
  import fl.controls.List;
  import flash.display.Sprite;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MatchmakingUserData;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MountItemsUserData;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;
  import utils.ScrollStyleUtils;

  public class GroupList extends Sprite {
    [Inject]
    public static var matchmakingGroupService:MatchmakingGroupService;

    private var header:GroupHeader = new GroupHeader();
    private var dataProvider:GroupUsersDataProvider;
    private var list:List;
    private var _width:Number;
    private var _height:Number;

    public function GroupList() {
      super();
      this.init();
      addChild(this.header);
    }

    public function resize(param1:Number, param2:Number) : void {
      this._width = param1;
      this._height = param2;
      this.header.width = this._width;
      this.list.y = 20;
      this.list.height = this._height - 20;
      var local3:Boolean = this.list.verticalScrollBar.visible > 0;
      this.list.width = local3 ? this._width + 7 : this._width - 1;
    }

    private function init() : void {
      this.list = new List();
      this.list.rowHeight = 20;
      this.list.setStyle("cellRenderer",GroupUsersListRenderer);
      this.list.focusEnabled = true;
      this.list.selectable = false;
      ScrollStyleUtils.setGreenStyle(this.list);
      this.dataProvider = new GroupUsersDataProvider();
      this.list.dataProvider = this.dataProvider;
      addEventListener(DeleteEvent.REMOVED,this.onUserDeleteClick);
      addChild(this.list);
    }

    private function onUserDeleteClick(param1:DeleteEvent) : void {
      var local2:Long = param1.data.id;
      matchmakingGroupService.removeUserFromGroup(local2);
    }

    public function addUser(param1:MatchmakingUserData) : void {
      this.dataProvider.addUser(param1);
      this.resize(this._width,this._height);
    }

    public function removeUser(param1:Long) : void {
      this.dataProvider.removeUser(param1);
      this.resize(this._width,this._height);
    }

    public function showUserReady(param1:Long) : void {
      this.dataProvider.setUserReady(param1);
    }

    public function showUserNotReady(param1:Long) : void {
      this.dataProvider.setUserNotReady(param1);
    }

    public function updateMountedItem(param1:MountItemsUserData) : void {
      this.dataProvider.updateMountedItem(param1);
    }

    public function isEveryoneReady() : Boolean {
      return this.dataProvider.isEveryoneReady();
    }

    public function fillMembersList(param1:Vector.<MatchmakingUserData>) : void {
      var local2:MatchmakingUserData = null;
      for each(local2 in param1) {
        this.dataProvider.addUser(local2);
      }
      this.resize(this._width,this._height);
    }

    public function removeAllUsers() : void {
      this.dataProvider.removeAllUsers();
      this.resize(this._width,this._height);
    }
  }
}
