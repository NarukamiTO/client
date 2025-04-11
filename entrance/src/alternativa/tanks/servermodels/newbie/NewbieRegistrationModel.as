package alternativa.tanks.servermodels.newbie {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.entrance.model.entrance.newbie.INewbieRegistrationModelBase;
  import projects.tanks.client.entrance.model.entrance.newbie.NewbieRegistrationModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  [ModelInfo]
  public class NewbieRegistrationModel extends NewbieRegistrationModelBase implements INewbieRegistrationModelBase, ObjectLoadListener {
    [Inject]
    public static var storageService:IStorageService;

    public function NewbieRegistrationModel() {
      super();
    }

    public function objectLoaded() : void {
      if(!this.haveVisitedTankiAlready()) {
        server.markUserAsNewbie();
      }
    }

    public function haveVisitedTankiAlready() : Boolean {
      return storageService.getStorage().data.alreadyPlayedTanks != null ? Boolean(storageService.getStorage().data.alreadyPlayedTanks) : false;
    }
  }
}
