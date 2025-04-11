package alternativa.tanks.models.clan.info {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.models.panel.create.ClanCreateService;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.tanks.models.service.ClanServiceEvent;
  import alternativa.tanks.models.service.ClanServiceUpdateEvent;
  import alternativa.types.Long;
  import flash.events.Event;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;
  import projects.tanks.client.clans.clan.info.ClanInfoCC;
  import projects.tanks.client.clans.clan.info.ClanInfoModelBase;
  import projects.tanks.client.clans.clan.info.IClanInfoModelBase;
  import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;

  [ModelInfo]
  public class ClanInfoModel extends ClanInfoModelBase implements IClanInfoModelBase, IClanInfoModel, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var createClanService:ClanCreateService;

    private var description:String;

    public function ClanInfoModel() {
      super();
    }

    public function objectLoaded() : void {
      clanService.addEventListener(ClanServiceUpdateEvent.UPDATE,getFunctionWrapper(this.onUpdateInfo));
      var local1:ClanInfoCC = getInitParam();
      var local2:Date = new Date(local1.createTime);
      clanService.clanMembers = local1.users.concat();
      clanService.name = local1.name;
      clanService.tag = local1.tag;
      clanService.minRankForRequest = local1.minRankForAddClan;
      clanService.creatorId = local1.creatorId;
      clanService.creationDate = DateFormatter.formatDateToLocalized(local2);
      clanService.isSelf = local1.self;
      putData(Boolean,local1.blocked);
      putData(String,local1.reasonForBlocking);
      clanService.isBlocked = local1.blocked;
      clanService.requestsEnabled = local1.incomingRequestEnabled;
      clanService.maxCharactersDescription = local1.maxCharactersDescription;
      this.description = local1.description;
      clanService.addEventListener(ClanServiceEvent.CLAN_BLOCK,getFunctionWrapper(this.onBlockClan));
      ClanInfoDelayed.getInstance().dispatchEvent(new Event(ClanInfoDelayed.EVENT_PREFIX + object.id.toString()));
    }

    private function onBlockClan(param1:ClanServiceEvent) : void {
      putData(Boolean,true);
      putData(String,param1.reasonBlock);
    }

    public function getDescription() : String {
      var local1:Object = getData(Boolean);
      if(Boolean(local1)) {
        return String(getData(String));
      }
      if(this.description != null) {
        return this.description;
      }
      return "";
    }

    public function getCreatorId() : Long {
      return getInitParam().creatorId;
    }

    public function getCreateTime() : Long {
      return getInitParam().createTime;
    }

    public function getUsersCount() : int {
      return getInitParam().users.length;
    }

    private function onUpdateInfo(param1:ClanServiceUpdateEvent) : void {
      this.description = param1.description;
      server.updateDescription(param1.description);
      server.changeFlag(param1.flag.id);
      server.changeMinRankForAddClan(param1.rankIndex);
      server.incomingRequestEnable(param1.incomingRequestsEnabled);
    }

    public function objectUnloaded() : void {
      clanService.unloadMembers();
      clanService.isSelf = false;
      clanService.removeEventListener(ClanServiceUpdateEvent.UPDATE,getFunctionWrapper(this.onUpdateInfo));
      clanService.removeEventListener(ClanServiceEvent.CLAN_BLOCK,getFunctionWrapper(this.onBlockClan));
    }

    public function getClanName() : String {
      return getInitParam().name;
    }

    public function getClanTag() : String {
      return getInitParam().tag;
    }

    public function getClanFlag() : ClanFlag {
      var local2:ClanFlag = null;
      var local1:int = 0;
      while(local1 < createClanService.flags.length) {
        local2 = createClanService.flags[local1];
        if(getInitParam().flagId == local2.id) {
          return local2;
        }
        local1++;
      }
      return createClanService.defaultFlag;
    }

    public function incomingRequestEnabled() : Boolean {
      return getInitParam().incomingRequestEnabled;
    }

    public function getRankIndexForAddClan() : int {
      return getInitParam().minRankForAddClan;
    }
  }
}
