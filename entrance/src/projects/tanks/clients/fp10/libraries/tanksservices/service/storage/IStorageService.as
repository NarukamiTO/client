package projects.tanks.clients.fp10.libraries.tanksservices.service.storage {
  import flash.net.SharedObject;

  public interface IStorageService {
    function getStorage() : SharedObject;
    function getAccountsStorage() : SharedObject;
  }
}
