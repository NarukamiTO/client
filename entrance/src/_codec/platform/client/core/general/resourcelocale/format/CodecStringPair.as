package _codec.platform.client.core.general.resourcelocale.format {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.core.general.resourcelocale.format.StringPair;

  public class CodecStringPair implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_key:ICodec;
    private var codec_value:ICodec;

    public function CodecStringPair() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_key = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_value = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:StringPair = new StringPair();
      local2.key = this.codec_key.decode(param1) as String;
      local2.value = this.codec_value.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:StringPair = StringPair(param2);
      this.codec_key.encode(param1,local3.key);
      this.codec_value.encode(param1,local3.value);
    }
  }
}
