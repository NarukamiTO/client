package alternativa.tanks.gui.friends.list.dataprovider {
  import alternativa.types.Long;
  import fl.data.DataProvider;
  import flash.utils.Dictionary;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleLinkData;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online.ClientOnlineNotifierData;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class FriendsDataProvider extends DataProvider {
    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    public static const IS_NEW:String = "isNew";
    public static const ID:String = "id";
    public static const ONLINE:String = "online";
    public static const IS_BATTLE:String = "isBattle";
    public static const UID:String = "uid";
    public static const AVAILABLE_INVITE:String = "availableInvite";
    public static const AVAILABLE_BATTLE:String = "availableBattle";

    private static var _escapePattern:RegExp = /\-|\./;
    private static var _globSearchPattern:RegExp = /\*/g;

    private var _getItemAtHandler:Function;
    private var _store:Dictionary = new Dictionary();
    private var _filterPropertyName:String;
    private var _filterString:String = "";
    private var _filterPattern:RegExp;
    private var _sortFields:Object;
    private var _sortFieldsProperties:Object;

    public function FriendsDataProvider() {
      super();
    }

    private static function prepareSearchPattern(param1:String) : RegExp {
      param1 = param1.replace(_escapePattern,"\\$&").replace(_globSearchPattern,".*");
      param1 = "^" + param1;
      return new RegExp(param1,"i");
    }

    public function get getItemAtHandler() : Function {
      return this._getItemAtHandler;
    }

    public function set getItemAtHandler(param1:Function) : void {
      this._getItemAtHandler = param1;
    }

    override public function getItemAt(param1:uint) : Object {
      var local2:Object = super.getItemAt(param1);
      if(this.getItemAtHandler != null) {
        this.getItemAtHandler(local2);
      }
      return local2;
    }

    public function setUserAsNew(param1:Long, param2:Boolean = true) : int {
      var local3:int = this.setPropertiesById(param1,IS_NEW,true);
      if(param2 && local3 != -1) {
        this.reSort();
      }
      return local3;
    }

    public function setOnlineUser(param1:ClientOnlineNotifierData, param2:Boolean = true) : int {
      var local3:int = this.setPropertiesById(param1.userId,ONLINE,param1.online);
      if(param2 && local3 != -1) {
        this.reSort();
      }
      return local3;
    }

    public function setBattleUser(param1:BattleLinkData, param2:Boolean = true) : int {
      var local3:int = this.setPropertiesById(param1.userId,IS_BATTLE,param1.isShowBattle());
      if(local3 != -1) {
        this.setPropertiesById(param1.userId,AVAILABLE_BATTLE,param1.availableRank());
        this.getItemAt(local3).battleData = param1;
      }
      if(param2 && local3 != -1) {
        this.reSort();
      }
      return local3;
    }

    public function updatePropertyAvailableInvite() : void {
      var local1:Object = null;
      var local2:int = int(this.length);
      var local3:int = 0;
      while(local3 < local2) {
        local1 = super.getItemAt(local3);
        local1.availableInvite = battleInfoService.availableRank(local1.rank);
        super.replaceItemAt(local1,local3);
        super.invalidateItemAt(local3);
        local3++;
      }
    }

    public function updatePropertyAvailableInviteById(param1:Long) : void {
      var local3:Object = null;
      var local2:int = this.setPropertiesById(param1,AVAILABLE_INVITE,false);
      if(local2 != -1) {
        local3 = super.getItemAt(local2);
        local3.availableInvite = battleInfoService.availableRank(local3.rank);
        super.replaceItemAt(local3,local2);
        super.invalidateItemAt(local2);
      }
    }

    public function clearBattleUser(param1:Long, param2:Boolean = true) : int {
      var local3:int = this.setPropertiesById(param1,IS_BATTLE,false);
      if(local3 != -1) {
        this.setPropertiesById(param1,AVAILABLE_BATTLE,false);
      }
      if(param2 && local3 != -1) {
        this.reSort();
      }
      return local3;
    }

    public function addUser(param1:Long, param2:Boolean = true) : void {
      var local6:BattleLinkData = null;
      var local3:IUserInfoLabelUpdater = userInfoService.getOrCreateUpdater(param1);
      var local4:Object = {};
      local4.id = param1;
      local4.uid = local3.uid;
      var local5:int = int(local3.rank);
      local4.rank = local5;
      local4.online = local3.online;
      local4.isNew = friendInfoService.isNewFriend(param1);
      local4.availableInvite = battleInfoService.availableRank(local5);
      local4.isBattle = false;
      local4.availableBattle = false;
      local4.snUid = local3.getSNUid();
      local4.isSNFriend = false;
      local4.isReferral = local3.isReferral();
      if(local3.hasBattleLink()) {
        local6 = local3.battleLink;
        local4.isBattle = local6.isShowBattle();
        local4.availableBattle = local6.availableRank();
      }
      super.addItem(local4);
      this._store[param1] = local4;
      if(param2) {
        this.refresh();
      }
    }

    public function removeUser(param1:Long) : void {
      if(!(param1 in this._store)) {
        return;
      }
      var local2:int = this.getItemIndexByProperty(ID,param1);
      if(local2 >= 0) {
        super.removeItemAt(local2);
      }
      delete this._store[param1];
    }

    override public function removeAll() : void {
      this._store = new Dictionary();
      super.removeAll();
    }

    public function refresh() : void {
      this.filter();
      this.reSort();
    }

    override public function sortOn(param1:Object, param2:Object = null) : * {
      this._sortFields = param1;
      this._sortFieldsProperties = param2;
      super.sortOn(this._sortFields,this._sortFieldsProperties);
    }

    public function reSort() : void {
      super.sortOn(this._sortFields,this._sortFieldsProperties);
    }

    public function setFilter(param1:String, param2:String) : void {
      if(param2 == "" && this._filterString != "") {
        this.resetFilter();
        return;
      }
      this._filterPropertyName = param1;
      this._filterString = param2;
      this._filterPattern = prepareSearchPattern(this._filterString);
      this.filter();
    }

    public function filter() : void {
      var local1:Object = null;
      if(this._filterString != "") {
        super.removeAll();
        for each(local1 in this._store) {
          if(this.isFilteredItem(local1)) {
            super.addItem(local1);
          }
        }
      }
      this.reSort();
    }

    public function resetFilter(param1:Boolean = true) : void {
      var local2:Object = null;
      this._filterString = "";
      if(!param1) {
        return;
      }
      super.removeAll();
      for each(local2 in this._store) {
        super.addItem(local2);
      }
      this.reSort();
    }

    private function isFilteredItem(param1:Object) : Boolean {
      return Boolean(param1.hasOwnProperty(this._filterPropertyName)) && param1[this._filterPropertyName].search(this._filterPattern) != -1;
    }

    public function setPropertiesById(param1:Long, param2:String, param3:Object) : int {
      var local5:Object = null;
      var local4:int = this.getItemIndexByProperty(ID,param1);
      if(local4 != -1) {
        local5 = super.getItemAt(local4);
        local5[param2] = param3;
        super.replaceItemAt(local5,local4);
        super.invalidateItemAt(local4);
      }
      if(param1 in this._store) {
        this._store[param1][param2] = param3;
      }
      return local4;
    }

    public function getItemIndexByProperty(param1:String, param2:*, param3:Boolean = false) : int {
      var local4:Object = null;
      var local7:* = undefined;
      var local5:int = int(this.length);
      var local6:int = 0;
      while(local6 < local5) {
        local4 = super.getItemAt(local6);
        if(local4 && local4.hasOwnProperty(param1) && local4[param1] == param2) {
          return local6;
        }
        local6++;
      }
      if(param3) {
        for(local7 in this._store) {
          local4 = this._store[local7];
          if(Boolean(local4.hasOwnProperty(param1)) && local4[param1] == param2) {
            return local6;
          }
        }
      }
      return -1;
    }
  }
}
