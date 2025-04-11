package alternativa.tanks.view.mainview.grouplist.item {
  import alternativa.types.Long;
  import fl.data.DataProvider;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MatchmakingUserData;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MountItemsUserData;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;

  public class GroupUsersDataProvider extends DataProvider {
    [Inject]
    public static var matchmakingGroupService:MatchmakingGroupService;

    private static const MAX_USERS_IN_GROUP:int = 3;

    private static var inviteUserSlot:Object = {"isInviteSlot":true};
    private static var emptySlot:Object = {"id":null};

    private var currentUsersCount:int = 0;

    public function GroupUsersDataProvider() {
      super();
      var local1:int = 0;
      while(local1 < MAX_USERS_IN_GROUP) {
        addItem(emptySlot);
        local1++;
      }
    }

    public function addUser(param1:MatchmakingUserData) : void {
      var local2:Object = {};
      local2.id = param1.id;
      local2.weaponName = param1.weaponName + " M" + param1.weaponModification;
      local2.armorName = param1.armorName + " M" + param1.armorModification;
      local2.ready = param1.userIsReady;
      replaceItemAt(local2,this.currentUsersCount);
      invalidateItemAt(this.currentUsersCount);
      ++this.currentUsersCount;
      if(this.currentUsersCount < MAX_USERS_IN_GROUP && Boolean(matchmakingGroupService.isGroupInviteEnabled())) {
        replaceItemAt(inviteUserSlot,this.currentUsersCount);
      }
      invalidate();
    }

    public function removeUser(param1:Long) : void {
      var local2:int = this.getItemIndexByUserId(param1);
      if(local2 >= 0) {
        removeItemAt(local2);
      }
      --this.currentUsersCount;
      addItem(emptySlot);
      if(matchmakingGroupService.isGroupInviteEnabled()) {
        replaceItemAt(inviteUserSlot,this.currentUsersCount);
      }
      invalidate();
    }

    public function setUserReady(param1:Long) : void {
      var local2:int = this.getItemIndexByUserId(param1);
      getItemAt(local2).ready = true;
      invalidateItemAt(local2);
    }

    public function setUserNotReady(param1:Long) : void {
      var local2:int = this.getItemIndexByUserId(param1);
      getItemAt(local2).ready = false;
      invalidateItemAt(local2);
    }

    public function updateMountedItem(param1:MountItemsUserData) : void {
      var local2:Long = param1.id;
      var local3:ItemCategoryEnum = param1.itemCategory;
      var local4:int = this.getItemIndexByUserId(local2);
      this.updateMountedItemByCategory(getItemAt(local4),param1,local3);
      invalidateItemAt(local4);
    }

    private function updateMountedItemByCategory(param1:Object, param2:MountItemsUserData, param3:ItemCategoryEnum) : void {
      switch(param3) {
        case ItemCategoryEnum.WEAPON:
          param1.weaponName = param2.name + " M" + param2.modification;
          break;
        case ItemCategoryEnum.ARMOR:
          param1.armorName = param2.name + " M" + param2.modification;
      }
    }

    public function removeAllUsers() : void {
      var local1:int = 0;
      while(local1 < MAX_USERS_IN_GROUP) {
        replaceItemAt(emptySlot,local1);
        local1++;
      }
      invalidate();
      this.currentUsersCount = 0;
    }

    public function isEveryoneReady() : Boolean {
      var local1:int = 0;
      while(local1 < this.currentUsersCount) {
        if(!getItemAt(local1).ready) {
          return false;
        }
        local1++;
      }
      return true;
    }

    private function getItemIndexByUserId(param1:Long) : int {
      var local2:Object = null;
      var local3:int = 0;
      while(local3 < this.currentUsersCount) {
        local2 = super.getItemAt(local3);
        if(local2["id"] == param1) {
          return local3;
        }
        local3++;
      }
      return -1;
    }
  }
}
