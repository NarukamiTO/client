package platform.client.fp10.core.registry {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.type.IGameObject;

  public interface ModelRegistry {
    function register(param1:Long, param2:Long) : void;
    function add(param1:IModel) : void;
    function registerModelConstructorCodec(param1:Long, param2:ICodec) : void;
    function getModelConstructorCodec(param1:Long) : ICodec;
    function invoke(param1:IGameObject, param2:Long, param3:ProtocolBuffer) : void;
    function getModel(param1:Long) : IModel;
    function registerAdapt(param1:Class, param2:Class) : void;
    function registerEvents(param1:Class, param2:Class) : void;
    function getAdaptClass(param1:Class) : Class;
    function getEventsClass(param1:Class) : Class;
    function get models() : Vector.<IModel>;
  }
}
