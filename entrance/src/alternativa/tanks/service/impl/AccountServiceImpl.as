package alternativa.tanks.service.impl {
  import alternativa.tanks.service.AccountService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class AccountServiceImpl implements AccountService {
    [Inject]
    public var storageService:IStorageService;

    public function AccountServiceImpl() {
      super();
    }

    public function get haveVisitedTankiAlready() : Boolean {
      return this.storageService.getStorage().data.alreadyPlayedTanks != null ? Boolean(this.storageService.getStorage().data.alreadyPlayedTanks) : false;
    }

    public function set haveVisitedTankiAlready(param1:Boolean) : void {
      this.storageService.getStorage().data.alreadyPlayedTanks = true;
    }

    public function get storedUserName() : String {
      return this.storageService.getStorage().data.userName;
    }

    public function set storedUserName(param1:String) : void {
      this.storageService.getStorage().data.userName = param1;
    }

    public function get entranceHash() : String {
      return this.storageService.getStorage().data.userHash;
    }
  }
}
