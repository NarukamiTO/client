package alternativa.tanks.servermodels.blockvalidator {
  import alternativa.tanks.service.IEntranceClientFacade;
  import alternativa.tanks.tracker.ITrackerService;
  import flash.net.SharedObject;
  import projects.tanks.client.entrance.model.entrance.blockvalidator.BlockValidatorModelBase;
  import projects.tanks.client.entrance.model.entrance.blockvalidator.IBlockValidatorModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  [ModelInfo]
  public class BlockValidatorModel extends BlockValidatorModelBase implements IBlockValidatorModelBase {
    [Inject]
    public static var clientFacade:IEntranceClientFacade;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var trackerService:ITrackerService;

    public function BlockValidatorModel() {
      super();
    }

    public function youAreBlocked(param1:String) : void {
      clientFacade.blockValidationAlert(param1);
      var local2:SharedObject = storageService.getStorage();
      local2.data.userHash = null;
      local2.flush();
      trackerService.trackEvent("entrance","youAreBlocked","");
    }

    public function youWereKicked(param1:String, param2:int, param3:int, param4:int) : void {
      clientFacade.kickValidationAlert(param1,param2,param3,param4);
      var local5:SharedObject = storageService.getStorage();
      local5.data.userHash = null;
      local5.flush();
      trackerService.trackEvent("entrance","youWereKicked","");
    }
  }
}
