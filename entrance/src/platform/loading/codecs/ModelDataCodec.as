package platform.loading.codecs {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.core.general.spaces.loading.modelconstructors.ModelData;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ModelDataCodec implements ICodec {
    [Inject]
    public static var clientLog:IClientLog;

    [Inject]
    public static var modelRegister:ModelRegistry;

    private var longCodec:ICodec;

    public function ModelDataCodec() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.longCodec = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:Object = null;
      var local3:Long = Long(this.longCodec.decode(param1));
      if(local3.low == 0 && local3.high == 0) {
        return new ModelData(this.longCodec.decode(param1),local3);
      }
      var local4:ICodec = modelRegister.getModelConstructorCodec(local3);
      if(local4 == null) {
        throw new Error("Constructor codec not found for model " + local3);
      }
      local2 = local4.decode(param1);
      return new ModelData(local2,local3);
    }
  }
}
