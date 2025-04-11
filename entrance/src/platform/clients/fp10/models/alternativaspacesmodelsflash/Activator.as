package platform.clients.fp10.models.alternativaspacesmodelsflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.logging.LogService;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.loading.DispatcherModel;
  import platform.loading.codecs.ModelDataCodec;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegister:ModelRegistry;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(LogService,function(param1:Object):void {
        DispatcherModel.logService = LogService(param1);
      },function():LogService {
        return DispatcherModel.logService;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        ModelDataCodec.clientLog = IClientLog(param1);
      },function():IClientLog {
        return ModelDataCodec.clientLog;
      });
      osgi.injectService(ModelRegistry,function(param1:Object):void {
        ModelDataCodec.modelRegister = ModelRegistry(param1);
      },function():ModelRegistry {
        return ModelDataCodec.modelRegister;
      });
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new DispatcherModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
