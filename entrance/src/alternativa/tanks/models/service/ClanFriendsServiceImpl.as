package alternativa.tanks.models.service {
  import alternativa.tanks.service.clan.ClanFriendsService;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;

  public class ClanFriendsServiceImpl extends EventDispatcher implements ClanFriendsService {
    private var _clanMembers:Vector.<Long>;

    public function ClanFriendsServiceImpl() {
      super();
    }

    public function get clanMembers() : Vector.<Long> {
      return this._clanMembers;
    }

    public function set clanMembers(param1:Vector.<Long>) : void {
      this._clanMembers = param1;
    }
  }
}
