package projects.tanks.clients.fp10.libraries.tanksservices.service.storage {
  import flash.net.SharedObject;

  public class StorageService implements IStorageService {
    private var storage:SharedObject;
    private var accountsStorage:SharedObject;

    public function StorageService(param1:SharedObject, param2:SharedObject) {
      super();
      this.storage = param1;
      this.accountsStorage = param2;
    }

    public function getStorage() : SharedObject {
      return this.storage;
    }

    public function getAccountsStorage() : SharedObject {
      return this.accountsStorage;
    }
  }
}
