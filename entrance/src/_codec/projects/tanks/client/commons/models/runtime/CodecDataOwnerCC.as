package _codec.projects.tanks.client.commons.models.runtime {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.commons.models.runtime.DataOwnerCC;

  public class CodecDataOwnerCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_dataOwnerId:ICodec;

    public function CodecDataOwnerCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_dataOwnerId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DataOwnerCC = new DataOwnerCC();
      local2.dataOwnerId = this.codec_dataOwnerId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DataOwnerCC = DataOwnerCC(param2);
      this.codec_dataOwnerId.encode(param1,local3.dataOwnerId);
    }
  }
}
