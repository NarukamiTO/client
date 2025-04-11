package projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck {
  import alternativa.osgi.OSGi;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.models.commons.types.ValidationStatus;
  import projects.tanks.client.tanksservices.model.uidcheck.IUidCheckModelBase;
  import projects.tanks.client.tanksservices.model.uidcheck.UidCheckModelBase;

  [ModelInfo]
  public class UidCheckModel extends UidCheckModelBase implements IUidCheckModelBase, ObjectLoadListener, ObjectUnloadListener, UidCheckService {
    private var validateCallback:Function;

    public function UidCheckModel() {
      super();
    }

    public function objectLoaded() : void {
      OSGi.getInstance().registerService(UidCheckService,object.adapt(UidCheckService));
    }

    public function objectUnloaded() : void {
      OSGi.getInstance().unregisterService(UidCheckService);
    }

    public function validateResult(param1:ValidationStatus) : void {
      if(Boolean(this.validateCallback)) {
        this.validateCallback(param1);
      }
      this.validateCallback = null;
    }

    public function getMaxLength() : int {
      return getInitParam().length;
    }

    public function exist(param1:String, param2:Function) : void {
      var uid:String = param1;
      var callback:Function = param2;
      this.validate(uid,function(param1:ValidationStatus):void {
        callback(param1 == ValidationStatus.NOT_UNIQUE);
      });
    }

    public function validate(param1:String, param2:Function) : void {
      this.validateCallback = param2;
      server.validateUid(param1);
    }
  }
}
