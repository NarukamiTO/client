package alternativa.tanks.models.panel.create {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.events.EventDispatcher;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class ClanCreateServiceImpl extends EventDispatcher implements ClanCreateService {
    [Inject]
    public static var localeService:ILocaleService;

    private var _flags:Vector.<ClanFlag> = new Vector.<ClanFlag>();

    public function ClanCreateServiceImpl() {
      super();
    }

    public function validateName(param1:String) : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.VALIDATE_NAME,param1));
    }

    public function validateTag(param1:String) : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.VALIDATE_TAG,null,param1));
    }

    public function createClan(param1:String, param2:String, param3:String, param4:ClanFlag) : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.CREATE,param1,param2,param3,param4));
    }

    public function incorrectName() : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.INCORRECT_NAME));
    }

    public function incorrectTag() : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.INCORRECT_TAG));
    }

    public function correctName() : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.CORRECT_NAME));
    }

    public function correctTag() : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.CORRECT_TAG));
    }

    public function notUniqueName() : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.NOT_UNIQUE_NAME));
    }

    public function notUniqueTag() : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.NOT_UNIQUE_TAG));
    }

    public function otherError() : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.OTHER_ERROR));
    }

    public function alreadyInClan() : void {
      dispatchEvent(new CreateClanServiceEvent(CreateClanServiceEvent.ALREADY_IN_CLAN));
    }

    public function get flags() : Vector.<ClanFlag> {
      return this._flags;
    }

    public function set flags(param1:Vector.<ClanFlag>) : void {
      this._flags = param1;
    }

    public function get defaultFlag() : ClanFlag {
      var local1:ClanFlag = null;
      for each(local1 in this._flags) {
        if(local1.name.toLowerCase() == localeService.language.toLowerCase()) {
          return local1;
        }
      }
      return this._flags[0];
    }
  }
}
