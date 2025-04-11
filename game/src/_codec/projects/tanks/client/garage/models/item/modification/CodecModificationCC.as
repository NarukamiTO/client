package _codec.projects.tanks.client.garage.models.item.modification {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Long;
  import projects.tanks.client.garage.models.item.modification.ModificationCC;

  public class CodecModificationCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_baseItemId:ICodec;
    private var codec_modificationIndex:ICodec;

    public function CodecModificationCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_baseItemId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_modificationIndex = param1.getCodec(new TypeCodecInfo(Byte,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ModificationCC = new ModificationCC();
      local2.baseItemId = this.codec_baseItemId.decode(param1) as Long;
      local2.modificationIndex = this.codec_modificationIndex.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ModificationCC = ModificationCC(param2);
      this.codec_baseItemId.encode(param1,local3.baseItemId);
      this.codec_modificationIndex.encode(param1,local3.modificationIndex);
    }
  }
}
