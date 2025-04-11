package platform.loading {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.types.Long;
  import platform.client.core.general.spaces.loading.dispatcher.DispatcherModelBase;
  import platform.client.core.general.spaces.loading.dispatcher.IDispatcherModelBase;
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsData;
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsDependencies;
  import platform.client.core.general.spaces.loading.modelconstructors.ModelData;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.client.fp10.core.registry.SpaceRegistry;
  import platform.client.fp10.core.resource.BatchResourceLoader;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import platform.client.fp10.core.service.errormessage.errors.UnclassifyedError;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import platform.client.fp10.core.type.impl.Space;
  import platform.loading.errors.ModelNotFoundError;
  import platform.loading.errors.ObjectLoadListenerError;

  [ModelInfo]
  public class DispatcherModel extends DispatcherModelBase implements IDispatcherModelBase {
    [Inject]
    public static var logService:LogService;

    private static var logger:Logger;

    private var modelRegister:ModelRegistry;
    private var resourceRegistry:ResourceRegistry;
    private var spaceRegistry:SpaceRegistry;

    public function DispatcherModel() {
      super();
      var local1:OSGi = OSGi.getInstance();
      this.modelRegister = local1.getService(ModelRegistry);
      this.resourceRegistry = local1.getService(ResourceRegistry);
      this.spaceRegistry = local1.getService(SpaceRegistry);
      logger = logger || logService.getLogger("dispatcher");
    }

    private static function logError(param1:Error) : void {
      var local2:String = param1.getStackTrace();
      logger.error(local2);
      showErrorMessage(local2);
    }

    private static function showErrorMessage(param1:String) : void {
      IErrorMessageService(OSGi.getInstance().getService(IErrorMessageService)).showMessage(new UnclassifyedError(param1));
    }

    public function loadDependencies(param1:ObjectsDependencies) : void {
      var local2:BatchResourceLoader = null;
      if(param1.callbackId > 0) {
        putData(ObjectsDependencies,param1);
      }
      if(param1.resources.length > 0) {
        local2 = this.getOrCreateBatchLoader();
        local2.load(param1.resources);
      } else if(param1.callbackId > 0) {
        if(getData(BatchResourceLoader) == null) {
          this.onBatchLoadingComplete();
        }
      }
    }

    private function getOrCreateBatchLoader() : BatchResourceLoader {
      var local1:BatchResourceLoader = BatchResourceLoader(getData(BatchResourceLoader));
      if(local1 == null) {
        local1 = new BatchResourceLoader(getFunctionWrapper(this.onBatchLoadingComplete));
        putData(BatchResourceLoader,local1);
      }
      return local1;
    }

    public function loadObjectsData(param1:ObjectsData) : void {
      this.loadModelData(param1);
      this.notifyLoadListeners(param1.objects);
    }

    private function loadModelData(param1:ObjectsData) : void {
      var local5:IGameObject = null;
      var local6:int = 0;
      var local7:ModelData = null;
      var local8:IModel = null;
      var local9:Object = null;
      var local2:Vector.<ModelData> = param1.modelsData;
      var local3:ISpace = this.spaceRegistry.currentSpace;
      var local4:int = 0;
      while(local4 < local2.length) {
        local5 = local3.getObject(Long(local2[local4].data));
        local4++;
        local6 = local4;
        while(local6 < local2.length && !(local2[local6].data is Long)) {
          local6++;
        }
        while(local4 < local6) {
          local7 = local2[local4];
          local8 = this.modelRegister.getModel(local7.id);
          if(local8 == null) {
            logError(new ModelNotFoundError(local3.id,local5.id,local7.id));
          } else {
            local9 = local7.data;
            if(local9 != null) {
              Model.object = local5;
              local8.putInitParams(local9);
              Model.popObject();
            }
          }
          local4++;
        }
      }
    }

    private function notifyLoadListeners(param1:Vector.<IGameObject>) : void {
      var object:IGameObject = null;
      var objects:Vector.<IGameObject> = param1;
      for each(object in objects) {
        try {
          this.notifyObjectLoadListeners(object);
        }
        catch(e:Error) {
          logError(new ObjectLoadListenerError(spaceRegistry.currentSpace.id,object.id,e));
        }
      }
    }

    private function notifyObjectLoadListeners(param1:IGameObject) : void {
      var local2:IObjectLoadListener = IObjectLoadListener(param1.event(IObjectLoadListener));
      local2.objectLoaded();
      ObjectLoadListener(param1.event(ObjectLoadListener)).objectLoaded();
      local2.objectLoadedPost();
      ObjectLoadPostListener(param1.event(ObjectLoadPostListener)).objectLoadedPost();
      Space(this.spaceRegistry.currentSpace).modelsDataReady(param1);
    }

    public function unloadObjects(param1:Vector.<IGameObject>) : void {
      var local3:IGameObject = null;
      var local2:ISpace = Model.object.space;
      for each(local3 in param1) {
        local2.destroyObject(local3.id);
      }
    }

    public function onBatchLoadingComplete() : void {
      var local1:ObjectsDependencies = ObjectsDependencies(clearData(ObjectsDependencies));
      server.dependeciesLoaded(local1.callbackId);
      clearData(BatchResourceLoader);
    }
  }
}
