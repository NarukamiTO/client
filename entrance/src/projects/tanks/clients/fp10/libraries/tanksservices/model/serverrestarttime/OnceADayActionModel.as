package projects.tanks.clients.fp10.libraries.tanksservices.model.serverrestarttime {
  import alternativa.osgi.OSGi;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.tanksservices.model.clientrestarttime.IOnceADayActionModelBase;
  import projects.tanks.client.tanksservices.model.clientrestarttime.OnceADayActionModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  [ModelInfo]
  public class OnceADayActionModel extends OnceADayActionModelBase implements IOnceADayActionModelBase, ObjectLoadListener, ObjectUnloadListener, OnceADayActionService {
    [Inject]
    public static var storageService:IStorageService;

    private static var ONCE_A_DAY_ACTIONS:String = "ONCE_A_DAY_ACTIONS";

    private var todayRestartTime:Number;

    public function OnceADayActionModel() {
      super();
    }

    public function objectLoaded() : void {
      OSGi.getInstance().registerService(OnceADayActionService,this);
      this.init();
    }

    public function init() : void {
      this.todayRestartTime = getInitParam().todayRestartTime * 1000;
    }

    public function verifyAndSaveAction(param1:String) : Boolean {
      var local2:Object = storageService.getStorage().data[ONCE_A_DAY_ACTIONS];
      if(local2 == null) {
        local2 = {};
      }
      var local3:Number = !!local2.hasOwnProperty(param1) ? Number(local2[param1]) : 0;
      if(local3 < this.todayRestartTime) {
        local2[param1] = new Date().time;
        storageService.getStorage().data[ONCE_A_DAY_ACTIONS] = local2;
        return true;
      }
      return false;
    }

    public function objectUnloaded() : void {
      OSGi.getInstance().unregisterService(OnceADayActionService);
    }
  }
}
