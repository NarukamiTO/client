package _codec.platform.client.core.general.spaces.loading.modelconstructors {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.core.general.spaces.loading.modelconstructors.ModelData;

  public class CodecModelData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_data:ICodec;
    private var codec_id:ICodec;

    public function CodecModelData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_data = param1.getCodec(new TypeCodecInfo(Object,false));
      this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ModelData = new ModelData();
      local2.data = this.codec_data.decode(param1) as Object;
      local2.id = this.codec_id.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ModelData = ModelData(param2);
      this.codec_data.encode(param1,local3.data);
      this.codec_id.encode(param1,local3.id);
    }
  }
}
