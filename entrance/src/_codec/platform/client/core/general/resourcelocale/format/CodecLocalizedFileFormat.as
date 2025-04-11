package _codec.platform.client.core.general.resourcelocale.format {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.core.general.resourcelocale.format.ImagePair;
  import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;
  import platform.client.core.general.resourcelocale.format.StringPair;

  public class CodecLocalizedFileFormat implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_images:ICodec;
    private var codec_strings:ICodec;

    public function CodecLocalizedFileFormat() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_images = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair,false),false,1));
      this.codec_strings = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:LocalizedFileFormat = new LocalizedFileFormat();
      local2.images = this.codec_images.decode(param1) as Vector.<ImagePair>;
      local2.strings = this.codec_strings.decode(param1) as Vector.<StringPair>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:LocalizedFileFormat = LocalizedFileFormat(param2);
      this.codec_images.encode(param1,local3.images);
      this.codec_strings.encode(param1,local3.strings);
    }
  }
}
