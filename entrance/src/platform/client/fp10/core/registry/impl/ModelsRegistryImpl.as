package platform.client.fp10.core.registry.impl {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;

  public class ModelsRegistryImpl implements ModelRegistry {
    [Inject]
    public static var protocol:IProtocol;

    private var logger:Logger;
    private var modelById:Dictionary;
    private var modelByMethod:Dictionary;
    private var model2constructorCodec:Dictionary;
    private var _models:Vector.<IModel>;
    private var class2Adapt:Dictionary = new Dictionary();
    private var class2Events:Dictionary = new Dictionary();

    public function ModelsRegistryImpl(param1:OSGi) {
      super();
      var local2:LogService = LogService(param1.getService(LogService));
      this.logger = local2.getLogger("modelsreg");
      this.modelById = new Dictionary();
      this.modelByMethod = new Dictionary();
      this.model2constructorCodec = new Dictionary();
      this._models = new Vector.<IModel>();
    }

    public function register(param1:Long, param2:Long) : void {
      this.modelByMethod[param2] = param1;
    }

    public function registerModelConstructorCodec(param1:Long, param2:ICodec) : void {
      this.model2constructorCodec[param1] = param2;
    }

    public function unregisterModelsParamsStruct(param1:Long) : void {
      delete this.model2constructorCodec[param1];
    }

    public function getModelConstructorCodec(param1:Long) : ICodec {
      return this.model2constructorCodec[param1];
    }

    public function add(param1:IModel) : void {
      this._models.push(param1);
      var local2:Long = param1.id;
      this.modelById[local2] = param1;
    }

    public function invoke(param1:IGameObject, param2:Long, param3:ProtocolBuffer) : void {
      var local4:Long = Long(this.modelByMethod[param2]);
      var local5:Model = Model(this.modelById[local4]);
      if(local5 != null) {
        Model.object = param1;
        local5.invoke(param2,param3);
        Model.popObject();
      }
    }

    public function getModel(param1:Long) : IModel {
      return this.modelById[param1];
    }

    public function get models() : Vector.<IModel> {
      return this._models;
    }

    public function registerAdapt(param1:Class, param2:Class) : void {
      this.class2Adapt[param1] = param2;
    }

    public function registerEvents(param1:Class, param2:Class) : void {
      this.class2Events[param1] = param2;
    }

    public function getAdaptClass(param1:Class) : Class {
      var local2:Class = this.class2Adapt[param1];
      if(local2 == null) {
        throw new Error("Proxy class not found for specified interface: " + param1);
      }
      return local2;
    }

    public function getEventsClass(param1:Class) : Class {
      var local2:Class = this.class2Events[param1];
      if(local2 == null) {
        throw new Error("Proxy class not found for specified interface: " + param1);
      }
      return local2;
    }
  }
}
