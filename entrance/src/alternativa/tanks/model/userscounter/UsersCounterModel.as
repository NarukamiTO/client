package alternativa.tanks.model.userscounter {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.userscounter.panel.IUsersCounterPanelModelBase;
  import projects.tanks.client.panel.model.userscounter.panel.UsersCounterPanelModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  [ModelInfo]
  public class UsersCounterModel extends UsersCounterPanelModelBase implements IUsersCounterPanelModelBase, ObjectLoadListener {
    [Inject]
    public static var storageService:IStorageService;

    public function UsersCounterModel() {
      super();
    }

    public function saveUniqueUserId(param1:Long) : void {
      var local2:Object = storageService.getStorage().data;
      local2.uniqueUserIdLowDWord = param1.low;
      local2.uniqueUserIdHighDWord = param1.high;
    }

    public function objectLoaded() : void {
      var local1:Long = this.getUserUniqueId();
      if(local1 == null) {
        server.hasNotUniqueUserId();
      } else {
        server.receiveUniqueUserId(local1);
      }
    }

    private function getUserUniqueId() : Long {
      var local1:Object = storageService.getStorage().data;
      if(local1.uniqueUserIdLowDWord == null || local1.uniqueUserIdHighDWord == null) {
        return null;
      }
      var local2:int = int(local1.uniqueUserIdLowDWord);
      var local3:int = int(local1.uniqueUserIdHighDWord);
      return Long.getLong(local3,local2);
    }
  }
}
