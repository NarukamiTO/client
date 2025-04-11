package _codec.projects.tanks.client.garage.models.item.item {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.garage.models.item.item.ItemModelCC;

  public class CodecItemModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_maxRank:ICodec;
    private var codec_minRank:ICodec;
    private var codec_position:ICodec;
    private var codec_preview:ICodec;

    public function CodecItemModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_maxRank = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_minRank = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_preview = param1.getCodec(new TypeCodecInfo(ImageResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemModelCC = new ItemModelCC();
      local2.maxRank = this.codec_maxRank.decode(param1) as int;
      local2.minRank = this.codec_minRank.decode(param1) as int;
      local2.position = this.codec_position.decode(param1) as int;
      local2.preview = this.codec_preview.decode(param1) as ImageResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ItemModelCC = ItemModelCC(param2);
      this.codec_maxRank.encode(param1,local3.maxRank);
      this.codec_minRank.encode(param1,local3.minRank);
      this.codec_position.encode(param1,local3.position);
      this.codec_preview.encode(param1,local3.preview);
    }
  }
}
