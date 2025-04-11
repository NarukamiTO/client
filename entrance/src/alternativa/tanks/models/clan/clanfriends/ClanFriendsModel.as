package alternativa.tanks.models.clan.clanfriends {
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.tanks.service.clan.ClanFriendsService;
  import alternativa.tanks.service.clan.ClanMembersListEvent;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.clan.clanfriends.ClanFriendsModelBase;
  import projects.tanks.client.clans.clan.clanfriends.IClanFriendsModelBase;

  [ModelInfo]
  public class ClanFriendsModel extends ClanFriendsModelBase implements IClanFriendsModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var clanFriendsService:ClanFriendsService;

    public function ClanFriendsModel() {
      super();
    }

    public function objectLoaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      clanFriendsService.clanMembers = getInitParam().users.concat();
    }

    public function onUserAdd(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      clanFriendsService.clanMembers.push(param1);
      clanFriendsService.dispatchEvent(new ClanMembersListEvent(ClanMembersListEvent.ACCEPTED_USER,param1));
    }

    public function onUserRemove(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      var local2:int = int(clanFriendsService.clanMembers.indexOf(param1));
      if(local2 >= 0) {
        clanFriendsService.clanMembers.splice(local2,1);
        clanFriendsService.dispatchEvent(new ClanMembersListEvent(ClanMembersListEvent.REMOVE_USER,param1));
      }
    }

    public function userJoinClan(param1:Vector.<Long>) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      clanFriendsService.clanMembers = param1.concat();
    }

    public function objectUnloaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      clanFriendsService.clanMembers = null;
    }

    private function isServiceSpace() : Boolean {
      return IClanUserModel(object.adapt(IClanUserModel)).loadingInServiceSpace();
    }
  }
}
